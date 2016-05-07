defmodule WdpaModels.Country do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "countries" do
    field :name, :string
    field :iso3, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :iso3])
    |> validate_required([:name, :iso3])
    |> validate_length(:iso3, is: 3)
  end
end
