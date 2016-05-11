defmodule WdpaPhoenix.ProtectedAreaView do
  use WdpaPhoenix.Web, :view

  def country_name(%{country: nil}),     do: ""
  def country_name(%{country: country}), do: country.name
end
