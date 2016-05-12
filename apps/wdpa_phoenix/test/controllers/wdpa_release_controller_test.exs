defmodule WdpaPhoenix.WdpaReleaseControllerTest do
  use WdpaPhoenix.ConnCase

  alias WdpaModels.WdpaRelease
  @valid_attrs %{name: "some content",
                 valid_from: Ecto.DateTime.cast!({{2016, 1, 1}, {0, 0, 0}}),
                 valid_to:   Ecto.DateTime.cast!({{2017, 1, 1}, {0, 0, 0}})}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, wdpa_release_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing wdpa releases"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, wdpa_release_path(conn, :new)
    assert html_response(conn, 200) =~ "New wdpa release"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, wdpa_release_path(conn, :create), wdpa_release: @valid_attrs
    assert redirected_to(conn) == wdpa_release_path(conn, :index)
    assert Repo.get_by(WdpaRelease, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, wdpa_release_path(conn, :create), wdpa_release: @invalid_attrs
    assert html_response(conn, 200) =~ "New wdpa release"
  end

  test "shows chosen resource", %{conn: conn} do
    wdpa_release = Repo.insert! %WdpaRelease{}
    conn = get conn, wdpa_release_path(conn, :show, wdpa_release)
    assert html_response(conn, 200) =~ "Show wdpa release"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, wdpa_release_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    wdpa_release = Repo.insert! %WdpaRelease{}
    conn = get conn, wdpa_release_path(conn, :edit, wdpa_release)
    assert html_response(conn, 200) =~ "Edit wdpa release"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    wdpa_release = Repo.insert! %WdpaRelease{}
    conn = put conn, wdpa_release_path(conn, :update, wdpa_release), wdpa_release: @valid_attrs
    assert redirected_to(conn) == wdpa_release_path(conn, :show, wdpa_release)
    assert Repo.get_by(WdpaRelease, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    wdpa_release = Repo.insert! %WdpaRelease{}
    conn = put conn, wdpa_release_path(conn, :update, wdpa_release), wdpa_release: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit wdpa release"
  end

  test "deletes chosen resource", %{conn: conn} do
    wdpa_release = Repo.insert! %WdpaRelease{}
    conn = delete conn, wdpa_release_path(conn, :delete, wdpa_release)
    assert redirected_to(conn) == wdpa_release_path(conn, :index)
    refute Repo.get(WdpaRelease, wdpa_release.id)
  end
end
