import Config

config :better_emojibot,
  # Set up an OAuth token for the application. Make sure that it has incoming-webhook and emoji:read permissions
  token: System.fetch_env!("SLACK_OAUTH_TOKEN"),
  # Set an incoming webhook for the channel of your choosing. This is where the bot will post
  hook_url: System.fetch_env!("SLACK_HOOK_URL")
