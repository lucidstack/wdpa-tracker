# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wdpa_models,
  ecto_repos: [WdpaModels.Repo]

config :wdpa_phoenix, ecto_repos: []

# Configures the endpoint
config :wdpa_phoenix, WdpaPhoenix.Endpoint,
  url: [host: "localhost"],
  root: Path.join(Path.dirname(__DIR__), "apps/wdpa_phoenix"),
  secret_key_base: "U9dk6xh8Bc3IUH1TaRp+TM3BvibrWsyVB5IN2sK34fF8UdR4jzTm2k270HufWTu3",
  render_errors: [view: WdpaPhoenix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WdpaPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
