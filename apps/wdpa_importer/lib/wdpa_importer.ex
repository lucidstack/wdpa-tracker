defmodule WdpaImporter do
  use WdpaModels
  import Logger
  alias WdpaModels.ProtectedArea
  alias WdpaImporter.Builder

  @file_reader Application.get_env(:wdpa_importer, :file_reader, File)

  # Public implementation
  #######################
  def run(path, nil), do:
    run(path, path |> Path.basename(".csv") |> Builder.wdpa_release)

  def run(path, wdpa_release) do
    path
    |> @file_reader.stream!
    |> CSV.decode(headers: true)
    |> Stream.map(&adapt_row/1)
    |> Stream.each(&save_row(&1, wdpa_release))
    |> Stream.run
  end

  # Private implementation
  ########################
  defp adapt_row(row) do
    %{wdpa_id: row["WDPAID"],
      country: row["ISO3"],
      designation: %{name: row["DESIG_ENG"],
                     type: row["DESIG_TYPE"]}}
  end

  defp save_row(row, wdpa_release) do
    Repo.transaction fn ->
      row
      |> put_wdpa_release(wdpa_release)
      |> put_country
      |> put_designation
      |> save_pa
      |> connect_release
    end
  end

  defp put_wdpa_release(row, wdpa_release), do:
    Map.put(row, :wdpa_release, wdpa_release)

  defp put_country(%{country: nil}  = row), do:
    Map.delete(row, :country)
  defp put_country(%{country: iso3} = row), do:
    Map.put(row, :country, Builder.country(iso3))

  defp put_designation(%{designation: %{name: nil}} = row), do:
    Map.delete(row, :designation)
  defp put_designation(%{designation: %{type: nil}} = row), do:
    Map.delete(row, :designation)
  defp put_designation(%{designation: %{name: name, type: type}} = row), do:
    Map.put(row, :designation, Builder.designation(name, type))

  defp save_pa(row) do
    pa_with_feedback = find_pa(row.wdpa_id)
    |> ProtectedArea.changeset(row)
    |> Repo.insert_or_update

    Map.put(row, :protected_area, pa_with_feedback)
  end

  defp connect_release(%{protected_area: {:error, err}, wdpa_id: id}), do:
    warn("couldn't import WDPAID #{id}, changeset: #{inspect err}")
  defp connect_release(%{protected_area: {:ok, pa}, wdpa_release: release}), do:
    build_assoc(pa, :protected_areas_in_wdpa_release, wdpa_release: release) |> Repo.insert!

  defp find_pa(wdpa_id) do
    pa = from(pa in ProtectedArea,
      where: pa.wdpa_id == ^wdpa_id,
      preload: [:country, :designation, :protected_areas_in_wdpa_release]
    ) |> Repo.one

    if pa, do: pa, else: %ProtectedArea{}
  end
end
