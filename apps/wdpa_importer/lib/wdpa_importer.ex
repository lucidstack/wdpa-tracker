defmodule WdpaImporter do
  use WdpaModels
  alias WdpaModels.Country
  alias WdpaModels.ProtectedArea
  alias WdpaModels.ProtectedAreasInWdpaRelease
  alias WdpaImporter.Release

  # Public implementation
  #######################
  def run(path, nil), do:
    run(path, path |> Path.basename(".csv") |> Release.create)

  def run(path, wdpa_release) do
    Logger.disable(self)
    Repo.transaction(fn -> do_run(path, wdpa_release) end, timeout: :infinity)
    Logger.enable(self)
  end

  def do_run(path, wdpa_release) do
    path
    |> File.stream!
    |> CSV.decode(headers: true)
    |> Stream.map(&adapt_map/1)
    |> Stream.map(&put_wdpa_release(&1, wdpa_release))
    |> Stream.map(&put_country/1)
    |> Stream.map(&save_pa/1)
    |> Stream.each(&connect_release/1)
    |> Stream.run
  end


  # Private implementation
  ########################
  defp adapt_map(map) do
    %{wdpa_id: map["WDPAID"],
      country: map["ISO3"],
      designation: %{name: map["DESIG_ENG"],
                    designation_type: map["DESIG_TYPE"]}}
  end

  defp put_wdpa_release(row, wdpa_release) do
    Map.put(row, :wdpa_release, wdpa_release)
  end

  defp put_country(%{country: nil}  = row), do: row
  defp put_country(%{country: iso3} = row) do
    country = case Repo.get_by(Country, iso3: iso3) do
      nil     -> %Country{iso3: iso3} |> Repo.insert!
      country -> country
    end

    Map.put(row, :country, country)
  end

  defp save_pa(row) do
    pa = %ProtectedArea{}
    |> ProtectedArea.changeset(row)
    |> Changeset.put_assoc(:country, row.country)
    |> Repo.insert!

    Map.put(row, :protected_area, pa)
  end

  defp connect_release(%{protected_area: pa, wdpa_release: release}) do
    pa
    |> build_assoc(:protected_areas_in_wdpa_release, wdpa_release: release)
    |> Repo.insert!
  end
end
