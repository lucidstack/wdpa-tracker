defmodule WdpaPhoenix.CountryController do
  use WdpaPhoenix.Web, :controller

  alias WdpaModels.Country

  def index(conn, _params) do
    countries = Repo.all(Country)
    render(conn, "index.html", countries: countries)
  end

  def new(conn, _params) do
    changeset = Country.changeset(%Country{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"country" => country_params}) do
    changeset = Country.changeset(%Country{}, country_params)

    case Repo.insert(changeset) do
      {:ok, _country} ->
        conn
        |> put_flash(:info, "Country created successfully.")
        |> redirect(to: country_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    country = Repo.get!(Country, id)
    render(conn, "show.html", country: country)
  end

  def edit(conn, %{"id" => id}) do
    country = Repo.get!(Country, id)
    changeset = Country.changeset(country)
    render(conn, "edit.html", country: country, changeset: changeset)
  end

  def update(conn, %{"id" => id, "country" => country_params}) do
    country = Repo.get!(Country, id)
    changeset = Country.changeset(country, country_params)

    case Repo.update(changeset) do
      {:ok, country} ->
        conn
        |> put_flash(:info, "Country updated successfully.")
        |> redirect(to: country_path(conn, :show, country))
      {:error, changeset} ->
        render(conn, "edit.html", country: country, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    country = Repo.get!(Country, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(country)

    conn
    |> put_flash(:info, "Country deleted successfully.")
    |> redirect(to: country_path(conn, :index))
  end
end
