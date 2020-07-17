defmodule AuditorDlex do
  @moduledoc """
  Documentation for AuditorDlex.
  """

  @doc """
    Inserts an item
  """
  def insert(params, actor) when is_map(params) do
    params
    |> Graph.Repo.set()
    |> case do
      {:ok, item} ->
        {:ok, actual_item} = Graph.Repo.get(item.uid)

        emit(:insert, actual_item, actor, nil)

        {:ok, item}

      response ->
        response
    end
  end

  def update(actual_item, changeset, actor)
      when is_map(changeset) do
    # Validate the params and emit audit
    changeset
    |> Graph.Repo.set()
    |> case do
      {:ok, item} ->
        emit(:update, actual_item, actor, Dlex.Changeset.apply_changes(changeset))

        {:ok, Dlex.Changeset.apply_changes(changeset)}

      response ->
        response
    end
  end

  def delete(%{uid: uid}, actor) when is_binary(uid) do
    :not_implemented
  end

  # Emits an telemetry
  def emit(action, item, actor, new_item \\ %{}) do
    :telemetry.execute([:dgraph, :item, action], actor, %{item: item, changes: new_item})
  end
end
