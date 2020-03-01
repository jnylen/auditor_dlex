defmodule AuditorDlex.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    attach_telemetry()

    children = []

    opts = [strategy: :one_for_one, name: AuditorDlex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp attach_telemetry() do
    :telemetry.attach_many(
      "auditor_dlex-logger-handler",
      [
        [:dgraph, :item, :insert],
        [:dgraph, :item, :update],
        [:dgraph, :item, :delete]
      ],
      &AuditorDlex.Logger.handle_event/4,
      nil
    )
  end
end
