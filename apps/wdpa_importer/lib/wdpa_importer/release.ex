defmodule WdpaImporter.Release do
  use WdpaModels
  alias WdpaModels.WdpaRelease

  def create("year-" <> <<year::binary-4>>) do
    {year, _} = year |> Integer.parse

    %WdpaRelease{
      name: "WDPA_#{year}",
      valid_from: make_date(1, year),
      valid_to:   make_date(1, year+1)
    } |> Repo.insert!
  end

  def create("month-" <> <<month::binary-2>> <> "-" <> <<year::binary-4>>) do
    {year,  _} = year  |> Integer.parse
    {month, _} = month |> Integer.parse

    %WdpaRelease{
      name: "WDPA_#{month}-#{year}",
      valid_from: make_date(month, year),
      valid_to:   make_date(month+1, year)
    } |> Repo.insert!
  end


  # Private implementation
  ########################
  defp make_date(13,    year), do: make_date(1, year+1)
  defp make_date(month, year), do: Ecto.DateTime.cast!({{year, month, 1}, {0, 0, 0}})
end
