defmodule PocUberauthWeb.PageControllerTest do
  use PocUberauthWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Don't forget to login !"
  end
end
