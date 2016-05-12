defmodule WdpaPhoenix.WdpaReleaseTest do
  use WdpaModels.ModelCase

  alias WdpaModels.WdpaRelease

  @valid_attrs %{name: "some content",
                 valid_from: Ecto.DateTime.cast!({{2016, 1, 1}, {0, 0, 0}})}
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
