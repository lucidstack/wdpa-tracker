defmodule WdpaPhoenix.ProtectedAreaView do
  use WdpaPhoenix.Web, :view

  def country_name(%{country: nil}),     do: ""
  def country_name(%{country: country}), do: country.name

  def country_iso3(%{country: nil}),     do: ""
  def country_iso3(%{country: country}), do: country.iso3

  def latest_wdpa_release(%{wdpa_releases: []}),        do: ""
  def latest_wdpa_release(%{wdpa_releases: [rel]}),     do: rel.name
  def latest_wdpa_release(%{wdpa_releases: [rel | _]}), do: rel.name
end
