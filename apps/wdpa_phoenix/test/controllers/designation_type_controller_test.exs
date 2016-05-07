defmodule WdpaPhoenix.DesignationTypeControllerTest do
  use WdpaPhoenix.ConnCase

  alias WdpaModels.DesignationType
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, designation_type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    designation_type = Repo.insert! %DesignationType{}
    conn = get conn, designation_type_path(conn, :show, designation_type)
    assert json_response(conn, 200)["data"] == %{"id" => designation_type.id,
      "name" => designation_type.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, designation_type_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, designation_type_path(conn, :create), designation_type: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(DesignationType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, designation_type_path(conn, :create), designation_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    designation_type = Repo.insert! %DesignationType{}
    conn = put conn, designation_type_path(conn, :update, designation_type), designation_type: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(DesignationType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    designation_type = Repo.insert! %DesignationType{}
    conn = put conn, designation_type_path(conn, :update, designation_type), designation_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    designation_type = Repo.insert! %DesignationType{}
    conn = delete conn, designation_type_path(conn, :delete, designation_type)
    assert response(conn, 204)
    refute Repo.get(DesignationType, designation_type.id)
  end
end
