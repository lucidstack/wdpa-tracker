defmodule WdpaPhoenix.Repo.Migrations.CreateProtectedAreasWithHistoryView do
  use Ecto.Migration

  def change do
    execute """
      CREATE VIEW protected_areas_with_history AS
        SELECT * FROM protected_areas
      UNION ALL
        SELECT * FROM protected_areas_history;
    """
  end
end
