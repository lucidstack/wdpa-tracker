defmodule WdpaPhoenix.ProtectedAreaController do
  use WdpaPhoenix.Web, :controller

  alias WdpaModels.ProtectedArea
  alias WdpaModels.ProtectedAreaWithHistory
  import WdpaModels.ProtectedAreaWithHistory

  def index(conn, _params) do
    protected_areas = ProtectedArea
    |> limit(10)
    |> preload(:country)
    |> Repo.all

    render(conn, "index.html", protected_areas: protected_areas)
  end


  def new(conn, _params) do
    changeset = ProtectedArea.changeset(%ProtectedArea{})
    render(conn, "new.html", changeset: changeset)
  end


  def create(conn, %{"protected_area" => protected_area_params}) do
    changeset = ProtectedArea.changeset(%ProtectedArea{}, protected_area_params)

    case Repo.insert(changeset) do
      {:ok, _protected_area} ->
        conn
        |> put_flash(:info, "Protected area created successfully.")
        |> redirect(to: protected_area_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def show(conn, %{"id" => id}) do
    protected_area = Repo.get!(ProtectedArea, id)
    render(conn, "show.html", protected_area: protected_area)
  end


  def edit(conn, %{"id" => id}) do
    protected_area = Repo.get!(ProtectedArea, id)
    changeset = ProtectedArea.changeset(protected_area)
    render(conn, "edit.html", protected_area: protected_area, changeset: changeset)
  end


  def update(conn, %{"id" => id, "protected_area" => protected_area_params}) do
    protected_area = Repo.get!(ProtectedArea, id)
    changeset = ProtectedArea.changeset(protected_area, protected_area_params)

    case Repo.update(changeset) do
      {:ok, protected_area} ->
        conn
        |> put_flash(:info, "Protected area updated successfully.")
        |> redirect(to: protected_area_path(conn, :show, protected_area))
      {:error, changeset} ->
        render(conn, "edit.html", protected_area: protected_area, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    protected_area = Repo.get!(ProtectedArea, id)
    Repo.delete!(protected_area)

    conn
    |> put_flash(:info, "Protected area deleted successfully.")
    |> redirect(to: protected_area_path(conn, :index))
  end
end
