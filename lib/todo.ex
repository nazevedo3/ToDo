defmodule ToDo do

  def new_todo() do
    { :ok, pid } = DynamicSupervisor.start_child(ToDo.Supervisor, ToDo.Server)
    pid
  end

  def show_list(list_pid) do
    GenServer.call(list_pid, { :show_list })
  end

  def add_item(list_pid, task) do
    GenServer.call(list_pid, { :add_item, task })
  end

  def complete_item(list_pid, item_id) do
    GenServer.call(list_pid, { :complete_item, item_id })
  end

end
