defmodule WdpaPhoenix.PageControllerTest do
  use WdpaPhoenix.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "WDPA Tracker"
  end
end
