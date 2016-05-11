defmodule WdpaPhoenix.Repo.Migrations.CreateWdpaRelease do
  use Ecto.Migration

  def change do
    create table(:wdpa_releases) do
      add :name, :text
      add :valid, :boolean, default: false, null: false

      timestamps
    end

  end
end
