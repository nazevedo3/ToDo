defmodule TextClient.Builder do
  alias TextClient.{State, Summary, Prompt, Updater}


  def being(%State{todo_service: %{status: :completed}} = todo) do
    completed_message("CONGRATULATIONS!!!  All of the items have been completed.  Way to be productive.  Take the rest of the day off.")
  end
  def begin(%State{todo_service: %{status: status}} = todo) when status in [ :new, :wip ] do
    continue(todo)
  end

  defp continue(todo) do
    todo
    |> Summary.display
    |> Prompt.accept_input
    |> Updater.update_list
    |> begin()
  end

  defp completed_message(msg) do
    IO.puts("\n", msg)
  end
end
