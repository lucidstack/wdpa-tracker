defmodule WdpaImporter.Builder do
  use WdpaModels
  alias WdpaModels.{Country, Designation, DesignationType, ProtectedArea, WdpaRelease}

  def wdpa_release("year-" <> <<year::binary-4>>) do
    {year, _} = year |> Integer.parse

    %WdpaRelease{name: "WDPA_#{year}", valid_from: make_date(1, year), valid_to: make_date(1, year+1)}
    |> Repo.insert!
  end

  def wdpa_release("month-" <> <<month::binary-2>> <> "-" <> <<year::binary-4>>) do
    {year,  _} = year  |> Integer.parse
    {month, _} = month |> Integer.parse

    %WdpaRelease{name: "WDPA_#{month}-#{year}", valid_from: make_date(month, year), valid_to: make_date(month+1, year)}
    |> Repo.insert!
  end

  def country(iso3) do
    country = Repo.get_by(Country, iso3: iso3)
    if country, do: country, else: %Country{iso3: iso3} |> Repo.insert!
  end

  def designation(name, type_name) do
    designation = Repo.get_by(Designation, name: name)

    if designation do
      designation
    else
      type = designation_type(type_name)
      %Designation{name: name, designation_type: type} |> Repo.insert!
    end
  end

  def designation_type(name) do
    type = Repo.get_by(DesignationType, name: name)
    if type, do: type, else: %DesignationType{name: name} |> Repo.insert!
  end

  # Private implementation
  ########################
  defp make_date(13,    year), do: make_date(1, year+1)
  defp make_date(month, year), do: Ecto.DateTime.cast!({{year, month, 1}, {0, 0, 0}})
end
