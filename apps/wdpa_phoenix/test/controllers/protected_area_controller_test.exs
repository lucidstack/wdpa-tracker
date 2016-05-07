defmodule WdpaPhoenix.ProtectedAreaControllerTest do
  use WdpaPhoenix.ConnCase

  alias WdpaModels.ProtectedArea
  @valid_attrs %{name: "some content", status: "some content", wdpa_id: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, protected_area_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing protected areas"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, protected_area_path(conn, :new)
    assert html_response(conn, 200) =~ "New protected area"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, protected_area_path(conn, :create), protected_area: @valid_attrs
    assert redirected_to(conn) == protected_area_path(conn, :index)
    assert Repo.get_by(ProtectedArea, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, protected_area_path(conn, :create), protected_area: @invalid_attrs
    assert html_response(conn, 200) =~ "New protected area"
  end

  test "shows chosen resource", %{conn: conn} do
    protected_area = Repo.insert! %ProtectedArea{}
    conn = get conn, protected_area_path(conn, :show, protected_area)
    assert html_response(conn, 200) =~ "Show protected area"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, protected_area_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    protected_area = Repo.insert! %ProtectedArea{}
    conn = get conn, protected_area_path(conn, :edit, protected_area)
    assert html_response(conn, 200) =~ "Edit protected area"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    protected_area = Repo.insert! %ProtectedArea{}
    conn = put conn, protected_area_path(conn, :update, protected_area), protected_area: @valid_attrs
    assert redirected_to(conn) == protected_area_path(conn, :show, protected_area)
    assert Repo.get_by(ProtectedArea, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    protected_area = Repo.insert! %ProtectedArea{}
    conn = put conn, protected_area_path(conn, :update, protected_area), protected_area: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit protected area"
  end

  test "deletes chosen resource", %{conn: conn} do
    protected_area = Repo.insert! %ProtectedArea{}
    conn = delete conn, protected_area_path(conn, :delete, protected_area)
    assert redirected_to(conn) == protected_area_path(conn, :index)
    refute Repo.get(ProtectedArea, protected_area.id)
  end
end
