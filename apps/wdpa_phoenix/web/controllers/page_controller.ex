defmodule WdpaPhoenix.PageController do
  use WdpaPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
