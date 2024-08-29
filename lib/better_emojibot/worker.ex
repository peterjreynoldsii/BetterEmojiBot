defmodule BetterEmojibot.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, name: __MODULE__)
  end

  def init(_) do
    main()
    {:ok, %{}}
  end

  def main do
    list_emojis()
    |> dif_emojis()
    |> format_result()
    |> send_message()

    Process.send_after(self(), :run, :timer.minutes(1))
  end

  def handle_info(:run, state) do
    main()
    {:noreply, state}
  end

  def headers,
    do: [{"Authorization", "Bearer #{Application.fetch_env!(:better_emojibot, :token)}"}]

  def list_emojis() do
    {:ok, %Req.Response{body: %{"emoji" => emojis}}} =
      Req.get(
        "https://slack.com/api/emoji.list",
        headers: headers()
      )

    emojis
  end

  def dif_emojis(emojis) do
    new_emojis =
      case File.read("list.txt") do
        {:ok, binary} ->
          old_emojis = Jason.decode!(Base.decode64!(binary))
          Map.drop(emojis, Map.keys(old_emojis))

        {:error, _} ->
          emojis
      end

    File.write!("list.txt", Base.encode64(Jason.encode!(emojis)))
    new_emojis
  end

  def format_result(result) do
    Enum.map_join(result, "\n", fn {name, _} ->
      ":#{name}: - #{name}"
    end)
  end

  def send_message(""), do: IO.puts("No new emojis!")

  def send_message(message) do
    IO.puts(message)

    {:ok, %Req.Response{status: 200, body: "ok"}} =
      Req.post(
        Application.fetch_env!(:better_emojibot, :hook_url),
        headers: headers(),
        body: Jason.encode!(%{text: message})
      )
  end
end
