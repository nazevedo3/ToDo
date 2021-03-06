defmodule ToDo.Actions do

  # Generates a new empty todo list
  def new_list() do
    %{
      status: :new,
      tasks: %{

      }
    }
  end

  # Show the current todo list
  def show_list(list) do
    IO.inspect list
  end

  # Add an item to the todo list
  def add_item(list, task) when is_binary(task) do
    put_in(list, [Access.key(:tasks, %{}), Access.key(1 + map_size(list[:tasks]))], %{name: task, completed: false, date_added: get_time(:calendar.local_time())})
    |> Map.put(:status, :wip)
  end

  def add_item(_list, _task), do: ~s(Your task must be wrapped in "quotes")

 # Mark an item as completed
 def complete_item(list, item_id) when is_number(item_id) do
  validate_item_id(list, item_id)
  end

  def complete_item(_list, _item_id), do: ~s(invalid item_id provided)

  defp get_time({{year, month, day}, {_, _, _}} = _time) do
    "#{month}.#{day}.#{year}"
  end


  defp validate_item_id(list, id) do
    Map.has_key?(list[:tasks], id)
    |> mark_as_complete(list, id)
  end

  defp mark_as_complete(true, list, item_id) do
    get_and_update_in(list[:tasks][item_id][:completed], &{&1, true})
    |> elem(1)
    |> maybe_completed()
  end

  defp mark_as_complete(_item_id_doesnt_exsist, _list , item_id), do: IO.inspect("#{item_id} isn't in your list.")

  defp maybe_completed(list) do
    items_completed = for {_, %{completed: true}} = item <- list[:tasks], do: item
    cond do
      length(items_completed) == map_size(list[:tasks]) -> update_status(list, :completed)
      true -> update_status(list, :wip)
    end
  end

  defp update_status(list, status), do: Map.put(list, :status, status)
end
