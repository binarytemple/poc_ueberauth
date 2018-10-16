defmodule PocUberauthWeb.PlugUserSession do
  import Plug.Conn

  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def call(conn, _opts) do
    assign(conn, :user_and_orgs, get_session(conn, :user_and_orgs))
  end
end
