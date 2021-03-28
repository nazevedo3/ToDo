defmodule TextClient.Updater do
  alias TextClient.State

  def update_list(%State{todo_service: %{status: status}} = todo) when status in [ :new, :wip ] do
    updated = ToDo.Actions.add_item(todo.todo_service, todo.add_task)
    |> Map.pop(:add_item)
    |> elem(1)
    %State{todo_service: updated}
  end
end
