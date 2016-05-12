defmodule WdpaPhoenix.Repo.Migrations.CreateWdpaRelease do
  use Ecto.Migration

  def change do
    create table(:wdpa_releases) do
      add :name, :text
      add :valid_from, :datetime
      add :valid_to,   :datetime

      timestamps
    end

    create index(:wdpa_releases, [:valid_from])
    create index(:wdpa_releases, [:valid_to])
  end
end
