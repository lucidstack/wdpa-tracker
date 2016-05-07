defmodule WdpaPhoenix.DesignationTypeView do
  use WdpaPhoenix.Web, :view

  def render("index.json", %{designation_types: designation_types}) do
    %{data: render_many(designation_types, WdpaPhoenix.DesignationTypeView, "designation_type.json")}
  end

  def render("show.json", %{designation_type: designation_type}) do
    %{data: render_one(designation_type, WdpaPhoenix.DesignationTypeView, "designation_type.json")}
  end

  def render("designation_type.json", %{designation_type: designation_type}) do
    %{id: designation_type.id,
      name: designation_type.name}
  end
end
