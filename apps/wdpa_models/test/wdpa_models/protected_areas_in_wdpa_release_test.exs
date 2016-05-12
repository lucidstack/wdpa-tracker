defmodule WdpaModels.ProtectedAreasInWdpaReleaseTest do
  use WdpaModels.ModelCase

  alias WdpaModels.ProtectedAreasInWdpaRelease

  @valid_attrs %{}
  @invalid_attrs %{protected_area_id: "dfasj"}

  test "changeset with valid attributes" do
    changeset = ProtectedAreasInWdpaRelease.changeset(%ProtectedAreasInWdpaRelease{}, @valid_attrs)
    assert changeset.valid?
  end

  @tag :skip
  test "changeset with invalid attributes" do
    changeset = ProtectedAreasInWdpaRelease.changeset(%ProtectedAreasInWdpaRelease{}, @invalid_attrs)
    refute changeset.valid?
  end
end
