defmodule Jauthn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Jauthn.PubSub},
      # Start the Endpoint (http/https)
      JauthnWeb.Endpoint
      # Start a worker by calling: Jauthn.Worker.start_link(arg)
      # {Jauthn.Worker, arg}
    ]

    :ets.new(:wax_session, [:named_table, :public, read_concurrency: true])

    Jauthn.User.init()

    opts = [strategy: :one_for_one, name: Jauthn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    JauthnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
