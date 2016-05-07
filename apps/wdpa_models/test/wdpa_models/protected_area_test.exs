defmodule WdpaModels.ProtectedAreaTest do
  use WdpaModels.ModelCase

  alias WdpaModels.ProtectedArea

  @valid_attrs %{name: "some content", status: "some content", wdpa_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProtectedArea.changeset(%ProtectedArea{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProtectedArea.changeset(%ProtectedArea{}, @invalid_attrs)
    refute changeset.valid?
  end
end
