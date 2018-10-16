defmodule PocUberauthWeb.AuthController do
  use PocUberauthWeb, :controller


  alias PocUberauth.UserAndOrgs

    plug Ueberauth

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do

    case UserAndOrgs.user_and_orgs_from_auth(auth) do
      %UserAndOrgs{login: login, email: email, orgs: orgs} = uao ->
        conn
        |> put_flash(:info, "Successfully authenticated: #{inspect(uao)} ")
        |> put_session(:login, login)
        |> put_session(:email, email)
        |> put_session(:orgs, orgs)
        |> redirect(to: "/")
      {:error, reason} ->
          conn
          |> put_flash(:error, reason)
          |> redirect(to: "/")
    end
  end


end
