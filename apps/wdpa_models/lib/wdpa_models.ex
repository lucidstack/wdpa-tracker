defmodule WdpaModels do
  use Application


  defmacro __using__(_opts) do
    quote do
      alias WdpaModels.Repo

      import Ecto
      import Ecto.Query
    end
  end

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the Ecto repository
      supervisor(WdpaModels.Repo, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WdpaModels.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
