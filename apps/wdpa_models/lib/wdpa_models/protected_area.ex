defmodule WdpaModels.ProtectedArea do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "protected_areas" do
    field :name, :string
    field :wdpa_id, :integer
    field :status, :string
    belongs_to :country, WdpaModels.Country
    belongs_to :designation, WdpaModels.Designation

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :wdpa_id, :status, :country_id])
    |> validate_required([:wdpa_id, :status])
  end
end
