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
        emit(:insert, item, current_user, nil)

        {:ok, item}

      response ->
        response
    end
  end

  def update(changeset, actor)
      when is_binary(uid) and is_map(changeset) do
    # Validate the params and emit audit
    changeset
    |> Graph.Repo.set()
    |> case do
      {:ok, item} ->
        emit(:update, item, actor, Dlex.Changeset.apply_changes(changeset))

        {:ok, item}

      response ->
        response
    end
  end

  def delete(%{uid: uid}, actor) when is_binary(uid) do
    :not_implemented
  end

  # Emits an telemetry
  def emit(action, item, actor, new_item \\ %{}) do
    :telemetry.execute([:dgraph, :item, action], %{item: item, changes: new_item}, actor)
  end
end
