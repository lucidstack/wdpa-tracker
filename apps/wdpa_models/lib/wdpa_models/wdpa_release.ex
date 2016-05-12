defmodule WdpaModels.WdpaRelease do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "wdpa_releases" do
    field :name, :string
    field :valid_from, Ecto.DateTime
    field :valid_to,   Ecto.DateTime

    has_many :protected_areas_in_wdpa_release, WdpaModels.ProtectedAreasInWdpaRelease
    has_many :protected_areas, through: [:protected_areas_in_wdpa_release,
                                         :protected_area]

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :valid_from, :valid_to])
    |> validate_required([:name, :valid_from])
  end
end
