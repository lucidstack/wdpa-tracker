defmodule WdpaPhoenix.WdpaReleaseTest do
  use WdpaModels.ModelCase

  alias WdpaModels.WdpaRelease

  @valid_attrs %{name: "some content", valid: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WdpaRelease.changeset(%WdpaRelease{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WdpaRelease.changeset(%WdpaRelease{}, @invalid_attrs)
    refute changeset.valid?
  end
end
