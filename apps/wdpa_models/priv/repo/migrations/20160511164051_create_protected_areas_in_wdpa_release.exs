defmodule WdpaModels.Repo.Migrations.CreateProtectedAreasInWdpaRelease do
  use Ecto.Migration

  def change do
    create table(:protected_areas_wdpa_releases) do
      add :protected_area_id, references(:protected_areas, on_delete: :nothing)
      add :wdpa_release_id, references(:wdpa_releases, on_delete: :nothing)

      timestamps
    end
    create index(:protected_areas_wdpa_releases, [:protected_area_id])
    create index(:protected_areas_wdpa_releases, [:wdpa_release_id])

  end
end
