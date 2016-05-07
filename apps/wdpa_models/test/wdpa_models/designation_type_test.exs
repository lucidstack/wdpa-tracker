defmodule WdpaModels.DesignationTypeTest do
  use WdpaModels.ModelCase

  alias WdpaModels.DesignationType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DesignationType.changeset(%DesignationType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DesignationType.changeset(%DesignationType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
