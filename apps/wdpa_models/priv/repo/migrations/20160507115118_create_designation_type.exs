defmodule WdpaPhoenix.Repo.Migrations.CreateDesignationType do
  use Ecto.Migration

  def change do
    create table(:designation_types) do
      add :name, :text

      timestamps
    end

  end
end
