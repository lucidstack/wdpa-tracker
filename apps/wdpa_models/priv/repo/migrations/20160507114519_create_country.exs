defmodule WdpaPhoenix.Repo.Migrations.CreateCountry do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :text
      add :iso3, :string, size: 3

      timestamps
    end

  end
end
