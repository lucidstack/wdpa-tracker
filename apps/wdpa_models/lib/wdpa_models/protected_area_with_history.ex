defmodule WdpaModels.ProtectedAreaWithHistory do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "protected_areas_with_history" do
    field :name, :string
    field :wdpa_id, :integer
    field :status, :string
    belongs_to :country, WdpaModels.Country
    belongs_to :designation, WdpaModels.Designation

    timestamps
  end

  defmacro changed_on(table_alias) do
    quote do
      fragment("lower(?)::timestamp", unquote(table_alias).sys_period)
    end
  end
end

