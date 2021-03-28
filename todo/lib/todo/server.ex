defmodule ToDo.Server do
  alias ToDo.Actions

  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    { :ok, Actions.new_list() }
  end

  def handle_call({ :show_list }, _from, list ) do
    { :reply, Actions.show_list(list), list }
  end

  def handle_call({ :add_item, task}, _from, list) do
    { :reply, Actions.add_item(list, task), list }
  end

  def handle_call({ :complete_item, item_id }, _from, list) do
    { :reply, Actions.complete_item(list, item_id), list }
  end

end
