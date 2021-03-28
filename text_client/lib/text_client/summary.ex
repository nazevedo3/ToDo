defmodule TextClient.Summary do
  alias TextClient.State

  def display(%State{todo_service: %{status: :new}} = todo) do
    IO.puts [
      "\n",
      "Welcome!  You currently have 0 items in your list.\n"
    ]
    todo
  end

  def display(%State{todo_service: %{status: :wip}} = todo) do
    IO.puts [
      "\n",
      "Task List: \n#{Enum.map(todo.todo_service[:tasks], fn {_, v} -> "#{v.name}\n"  end)}\n"
    ]
    todo
  end
end
