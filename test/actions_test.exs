defmodule ActionsTest do
  use ExUnit.Case

  alias ToDo.Actions

  test "creates a new blank list" do
    new_list = Actions.new_list
    assert new_list[:status] == :new
    assert map_size(new_list[:tasks]) == 0
  end

  test "add one item to a list" do
    new_list = Actions.new_list() |> Actions.add_item("walk the dog")
    assert new_list[:status] == :wip
    assert map_size(new_list[:tasks]) == 1
    assert get_in(new_list[:tasks], [1, :name]) == "walk the dog"
  end

  test "add multiple items to a list" do
    new_list = Actions.new_list() |> Actions.add_item("walk the dog") |> Actions.add_item("make dinner") |> Actions.add_item("watch the game") |> Actions.add_item("practice coding")
    assert new_list[:status] == :wip
    assert map_size(new_list[:tasks]) == 4
  end

  test "complete one item in the list" do
    new_list = Actions.new_list() |> Actions.add_item("walk the dog") |> Actions.add_item("make dinner") |> Actions.add_item("watch the game") |> Actions.add_item("practice coding")
    |> Actions.complete_item(4)
    assert new_list[:status] == :wip
    assert get_in(new_list[:tasks], [4, :completed]) == true
  end

  test "status changes to completed when all items in the list are done" do
    completed_list = Actions.new_list() |> Actions.add_item("walk the dog") |> Actions.add_item("make dinner") |> Actions.add_item("watch the game") |> Actions.add_item("practice coding")
    |> Actions.complete_item(1)
    |> Actions.complete_item(2)
    |> Actions.complete_item(3)
    |> Actions.complete_item(4)
    assert completed_list[:status] == :completed
  end

  test "non string provided as a task" do
    new_list = Actions.new_list
    assert Actions.add_item(new_list, 500) == ~s(Your task must be wrapped in "quotes")
    assert Actions.add_item(new_list, 'walk the dog') == ~s(Your task must be wrapped in "quotes")
    assert Actions.add_item(new_list, %{item: "walk the dog"}) == ~s(Your task must be wrapped in "quotes")
    assert Actions.add_item(new_list, ["walk the dog, make dinner"]) == ~s(Your task must be wrapped in "quotes")
  end

  test "non existing item_id provided to mark as completed" do
    new_list = Actions.new_list() |> Actions.add_item("walk the dog") |> Actions.add_item("make dinner") |> Actions.add_item("watch the game") |> Actions.add_item("practice coding")
    assert Actions.complete_item(new_list, 10) == "10 isn't in your list."
  end

  test "non number provided for item_id when completing an task" do
    completed_list = Actions.new_list() |> Actions.add_item("walk the dog") |> Actions.add_item("make dinner") |> Actions.add_item("watch the game") |> Actions.add_item("practice coding")
    assert ToDo.complete_item(completed_list, "3") == "invalid item_id provided"
    assert ToDo.complete_item(completed_list, '3') == "invalid item_id provided"
    assert ToDo.complete_item(completed_list, "number 3") == "invalid item_id provided"
  end
end
