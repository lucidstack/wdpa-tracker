use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wdpa_phoenix, WdpaPhoenix.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure wdpa_importer
config :wdpa_importer, file_reader: WdpaImporter.Test.FileMock

# Configure your database
config :wdpa_models, WdpaModels.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "wdpa_phoenix_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
