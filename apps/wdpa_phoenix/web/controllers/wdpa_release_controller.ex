defmodule WdpaPhoenix.WdpaReleaseController do
  use WdpaPhoenix.Web, :controller

  alias WdpaModels.WdpaRelease

  def index(conn, _params) do
    wdpa_releases = Repo.all(WdpaRelease)
    render(conn, "index.html", wdpa_releases: wdpa_releases)
  end

  def new(conn, _params) do
    changeset = WdpaRelease.changeset(%WdpaRelease{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wdpa_release" => wdpa_release_params}) do
    changeset = WdpaRelease.changeset(%WdpaRelease{}, wdpa_release_params)

    case Repo.insert(changeset) do
      {:ok, _wdpa_release} ->
        conn
        |> put_flash(:info, "Wdpa release created successfully.")
        |> redirect(to: wdpa_release_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wdpa_release = Repo.get!(WdpaRelease, id)
    render(conn, "show.html", wdpa_release: wdpa_release)
  end

  def edit(conn, %{"id" => id}) do
    wdpa_release = Repo.get!(WdpaRelease, id)
    changeset = WdpaRelease.changeset(wdpa_release)
    render(conn, "edit.html", wdpa_release: wdpa_release, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wdpa_release" => wdpa_release_params}) do
    wdpa_release = Repo.get!(WdpaRelease, id)
    changeset = WdpaRelease.changeset(wdpa_release, wdpa_release_params)

    case Repo.update(changeset) do
      {:ok, wdpa_release} ->
        conn
        |> put_flash(:info, "Wdpa release updated successfully.")
        |> redirect(to: wdpa_release_path(conn, :show, wdpa_release))
      {:error, changeset} ->
        render(conn, "edit.html", wdpa_release: wdpa_release, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wdpa_release = Repo.get!(WdpaRelease, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(wdpa_release)

    conn
    |> put_flash(:info, "Wdpa release deleted successfully.")
    |> redirect(to: wdpa_release_path(conn, :index))
  end
end
