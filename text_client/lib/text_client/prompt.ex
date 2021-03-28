defmodule TextClient.Prompt do
  alias TextClient.State

  def accept_input(%State{} = todo) do
    IO.gets("Please add an item to your list\n")
    |> check_input(todo)
  end

  defp check_input({:error, reason}, _) do
    IO.puts("Exited for your list #{reason}\n")
  end

  defp check_input(:eof, _) do
    IO.puts("Looks like you wanted to leave...")
    exit(:normal)
  end

  defp check_input(input, %State{} = todo) do
    input = String.trim(input)
    Map.put(todo, :add_task, input)
  end
end
