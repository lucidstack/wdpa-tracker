defmodule WdpaModels.Repo.Migrations.AddSysPeriodToProtectedAreasTable do
  use Ecto.Migration

  def change do
    alter table(:protected_areas) do
      add :sys_period, :tstzrange, null: false,
          default: fragment("tstzrange(current_timestamp, null)")
    end
  end
end
