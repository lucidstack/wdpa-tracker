defmodule WdpaPhoenix.DesignationTypeController do
  use WdpaPhoenix.Web, :controller

  alias WdpaModels.DesignationType

  def index(conn, _params) do
    designation_types = Repo.all(DesignationType)
    render(conn, "index.json", designation_types: designation_types)
  end

  def create(conn, %{"designation_type" => designation_type_params}) do
    changeset = DesignationType.changeset(%DesignationType{}, designation_type_params)

    case Repo.insert(changeset) do
      {:ok, designation_type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", designation_type_path(conn, :show, designation_type))
        |> render("show.json", designation_type: designation_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(WdpaPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    designation_type = Repo.get!(DesignationType, id)
    render(conn, "show.json", designation_type: designation_type)
  end

  def update(conn, %{"id" => id, "designation_type" => designation_type_params}) do
    designation_type = Repo.get!(DesignationType, id)
    changeset = DesignationType.changeset(designation_type, designation_type_params)

    case Repo.update(changeset) do
      {:ok, designation_type} ->
        render(conn, "show.json", designation_type: designation_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(WdpaPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    designation_type = Repo.get!(DesignationType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(designation_type)

    send_resp(conn, :no_content, "")
  end
end
