defmodule BetterEmojiBot.Worker do
  use GenServer

  def init(_) do
    {:ok, %{}}
  end

  def start_link() do

  end

  def list_emojis() do
    Req.get("https://slack.com/api/emoji.list")
  end
end
