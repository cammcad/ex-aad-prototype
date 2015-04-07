use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :interlineClient, InterlineClient.Endpoint,
  secret_key_base: "hBZe7iE0Sr1TEm0QERCcxoHeu9DSg9Qy+i9HJsXgJnJz7pGqdgL+seMsRWG6Ykje"

# Configure your database
config :interlineClient, InterlineClient.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "interlineClient_prod"
