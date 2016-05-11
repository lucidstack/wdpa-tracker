defmodule WdpaModels.WdpaRelease do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "wdpa_releases" do
    field :name, :string
    field :valid, :boolean, default: false

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :valid])
    |> validate_required([:name, :valid])
  end
end
