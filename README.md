# BetterEmojibot

This bot posts a list of all new emoji added to a slack instance as they are added. 

## Installation

In your `.envrc` file, add the following tokens:
```
export SLACK_API_TOKEN= (insert token with connections:write permissions here)
export SLACK_HOOK_URL= (insert webhook URL here, configured to your channel of choice)
```

When this is set, run `mix run --no-halt` and leave running indefinitely. 

Enjoy!
(pull requests accepted)