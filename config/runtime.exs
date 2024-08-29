import Config

config :better_emojibot,
  token: System.fetch_env!("SLACK_OAUTH_TOKEN"),
  hook_url: System.fetch_env!("SLACK_HOOK_URL")
