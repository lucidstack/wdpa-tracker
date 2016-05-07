defmodule WdpaModels.Repo.Migrations.CreateProtectedArea do
  use Ecto.Migration

  def change do
    create table(:protected_areas) do
      add :name, :text
      add :wdpa_id, :integer
      add :status, :text
      add :country_id, references(:countries, on_delete: :nothing)
      add :designation_id, references(:designations, on_delete: :nothing)

      timestamps
    end
    create index(:protected_areas, [:country_id])
    create index(:protected_areas, [:designation_id])

  end
end
