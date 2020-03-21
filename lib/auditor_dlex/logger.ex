defmodule AuditorDlex.Logger do
  require Logger

  def handle_event([:dgraph, :item, :insert], actor, %{item: item}, _config) do
    # Logger.info("[item_created] #{item.uid} added by user #{actor.id}")
    Auditor.log(:insert, item, actor, nil)
  end

  def handle_event([:dgraph, :item, :update], actor, %{item: item, changes: changes}, _config) do
    # Logger.info("[item_updated] #{item.uid} updated by user #{actor.id} - #{inspect(changes)}")
    Auditor.log(:update, item, actor, changes)
  end

  def handle_event([:dgraph, :item, :delete], actor, %{item: item}, _config) do
    # Logger.info("[item_deleted] #{item.uid} deleted by user #{actor.id}")
    Auditor.log(:delete, item, actor, nil)
  end
end
