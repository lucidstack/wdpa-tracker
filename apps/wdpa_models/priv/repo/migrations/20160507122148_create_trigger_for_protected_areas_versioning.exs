defmodule WdpaModels.Repo.Migrations.CreateTriggerForProtectedAreasVersioning do
  use Ecto.Migration

  def change do
    execute """
      CREATE TRIGGER versioning_trigger
      BEFORE INSERT OR UPDATE OR DELETE ON protected_areas
      FOR EACH ROW EXECUTE PROCEDURE versioning(
        'sys_period', 'protected_areas_history', true
      )
    """
  end
end
