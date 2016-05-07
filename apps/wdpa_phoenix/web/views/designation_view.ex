defmodule WdpaPhoenix.DesignationView do
  use WdpaPhoenix.Web, :view

  def render("index.json", %{designations: designations}) do
    %{data: render_many(designations, WdpaPhoenix.DesignationView, "designation.json")}
  end

  def render("show.json", %{designation: designation}) do
    %{data: render_one(designation, WdpaPhoenix.DesignationView, "designation.json")}
  end

  def render("designation.json", %{designation: designation}) do
    %{id: designation.id,
      name: designation.name,
      designation_type_id: designation.designation_type_id}
  end
end
