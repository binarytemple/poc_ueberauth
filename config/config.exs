# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :poc_uberauth,
  ecto_repos: [PocUberauth.Repo]

# Configures the endpoint
config :poc_uberauth, PocUberauthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y0IMxF+Uv7oKqDApK0EFLBvAWyHgqXYMMhh+uM46/NVxzrSUYC9iWIeAJqiX9dEq",
  render_errors: [view: PocUberauthWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PocUberauth.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [default_scope: "read:user, user:email,read:org "]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("POC_UBERAUTH_GITHUB_CLIENT_ID"),
  client_secret: System.get_env("POC_UBERAUTH_GITHUB_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
