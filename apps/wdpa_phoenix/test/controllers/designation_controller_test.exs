defmodule WdpaPhoenix.DesignationControllerTest do
  use WdpaPhoenix.ConnCase

  alias WdpaModels.Designation
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, designation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    designation = Repo.insert! %Designation{}
    conn = get conn, designation_path(conn, :show, designation)
    assert json_response(conn, 200)["data"] == %{"id" => designation.id,
      "name" => designation.name,
      "designation_type_id" => designation.designation_type_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, designation_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, designation_path(conn, :create), designation: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Designation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, designation_path(conn, :create), designation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    designation = Repo.insert! %Designation{}
    conn = put conn, designation_path(conn, :update, designation), designation: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Designation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    designation = Repo.insert! %Designation{}
    conn = put conn, designation_path(conn, :update, designation), designation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    designation = Repo.insert! %Designation{}
    conn = delete conn, designation_path(conn, :delete, designation)
    assert response(conn, 204)
    refute Repo.get(Designation, designation.id)
  end
end
