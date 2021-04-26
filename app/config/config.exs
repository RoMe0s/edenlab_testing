# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :edenlab,
  ecto_repos: [Edenlab.Repo]

# Configures the endpoint
config :edenlab, EdenlabWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gRi1PYAa03nDhk+ydFvHJJWLLRTlRcbkgX7Rp/o/A15NC4N+JTuKTij3FvfADM6t",
  render_errors: [view: EdenlabWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Edenlab.PubSub,
  live_view: [signing_salt: "IPCAhM5A"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
