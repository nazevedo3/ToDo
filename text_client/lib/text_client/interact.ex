defmodule TextClient.Interact do
    alias TextClient.{State, Prompt, Updater, Summary, Builder}

  def start() do
    new_list()
    |> setup_state
    |> Builder.begin
  end

  defp setup_state(todo) do
    %State{
      todo_service: todo
    }
  end

  defp new_list() do
    ToDo.Actions.new_list()
  end
end
