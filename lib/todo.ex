defmodule ToDo do
  alias ToDo.Actions

defdelegate new_list(), to: Actions
defdelegate show_list(list), to: Actions
defdelegate add_item(list, task), to: Actions
defdelegate delete_item(), to: Actions

end