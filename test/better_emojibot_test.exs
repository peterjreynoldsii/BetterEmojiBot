defmodule BetterEmojibotTest do
  use ExUnit.Case
  doctest BetterEmojibot

  test "greets the world" do
    assert BetterEmojibot.hello() == :world
  end
end
