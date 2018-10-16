defmodule PocUberauthWeb.PageController do
  use PocUberauthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
