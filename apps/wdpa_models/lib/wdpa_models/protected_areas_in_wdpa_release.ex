defmodule WdpaModels.ProtectedAreasInWdpaRelease do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "protected_areas_wdpa_releases" do
    belongs_to :protected_area, WdpaModels.ProtectedArea
    belongs_to :wdpa_release, WdpaModels.WdpaRelease

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> cast_assoc(:wdpa_release)
    |> validate_required([])
  end
end
