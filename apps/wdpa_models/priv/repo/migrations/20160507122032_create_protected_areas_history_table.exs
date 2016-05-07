defmodule WdpaPhoenix.Repo.Migrations.CreateProtectedAreasHistoryTable do
  use Ecto.Migration

  def change do
    execute "CREATE TABLE protected_areas_history (LIKE protected_areas)"
  end
end
