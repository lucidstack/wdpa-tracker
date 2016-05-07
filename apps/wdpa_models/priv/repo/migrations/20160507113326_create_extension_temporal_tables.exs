defmodule WdpaPhoenix.Repo.Migrations.CreateExtensionTemporalTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS temporal_tables"
  end
end
