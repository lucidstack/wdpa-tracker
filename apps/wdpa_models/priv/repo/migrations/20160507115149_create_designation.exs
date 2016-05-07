defmodule WdpaPhoenix.Repo.Migrations.CreateDesignation do
  use Ecto.Migration

  def change do
    create table(:designations) do
      add :name, :text
      add :designation_type_id, references(:designation_types, on_delete: :delete_all)

      timestamps
    end
    create index(:designations, [:designation_type_id])

  end
end
