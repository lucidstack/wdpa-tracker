defmodule WdpaModels.CountryTest do
  use WdpaModels.ModelCase
  alias WdpaModels.Country

  @valid_attrs %{iso3: "ITA", name: "Italy"}
  @invalid_attrs %{iso3: "HEYHOWAREYOUDOING", name: "NOTBAD"}

  test "changeset with valid attributes" do
    changeset = Country.changeset(%Country{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Country.changeset(%Country{}, @invalid_attrs)
    refute changeset.valid?
  end
end
