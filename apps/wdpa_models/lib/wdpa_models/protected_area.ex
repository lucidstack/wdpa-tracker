defmodule WdpaModels.ProtectedArea do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "protected_areas" do
    field :name, :string
    field :wdpa_id, :integer
    belongs_to :country, WdpaModels.Country
    belongs_to :designation, WdpaModels.Designation

    has_many :protected_areas_in_wdpa_release, WdpaModels.ProtectedAreasInWdpaRelease
    has_many :wdpa_releases, through: [:protected_areas_in_wdpa_release,
                                      :wdpa_release]

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :wdpa_id])
    |> unique_constraint(:wdpa_id, name: :protected_areas_pkey)
    |> validate_required([:wdpa_id])
  end
end
