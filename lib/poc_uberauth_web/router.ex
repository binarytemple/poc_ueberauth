defmodule PocUberauthWeb.Router do
  use PocUberauthWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(PocUberauthWeb.PlugUserSession)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PocUberauthWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  scope "/auth", PocUberauthWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", PocUberauthWeb do
  #   pipe_through :api
  # end
end
