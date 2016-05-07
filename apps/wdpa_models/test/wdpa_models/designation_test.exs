defmodule WdpaModels.DesignationTest do
  use WdpaModels.ModelCase

  alias WdpaModels.Designation

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Designation.changeset(%Designation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Designation.changeset(%Designation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
