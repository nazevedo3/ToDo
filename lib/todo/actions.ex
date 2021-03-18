defmodule ToDo.Actions do
  #alias ToDo.Item

  def new_list() do
    %{
      tasks: [%{
        id: 0,
        name: "",
        date_added: "",
        completed: false,
      }]
    }
  end

  def show_list(%{} = list) do
    IO.inspect list
  end

  def add_item(%{tasks: [%{id: id}]} = _list, task) when id == 0 do
    %{
      tasks: [%{
        id: + 1,
        name: task,
        date_added: get_time(:calendar.local_time()),
        completed: false
      }]
    }
  end

  def add_item(%{tasks: _task } = list, task) when is_binary(task)  do
    %{list | tasks: list[:tasks] ++ [%{id: length(list.tasks) + 1, name: task, date_added: get_time(:calendar.local_time()), completed: false}]}
   end

   def add_item(_list, _task), do: ~s(Your task must be wrapped in "quotes")

 def delete_item() do

 end

  defp get_time({{year, month, day}, {_, _, _}} = _time) do
    "#{month}.#{day}.#{year}"
  end

end
