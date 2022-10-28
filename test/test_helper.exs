ExUnit.start()

Config.Reader.read!("config/test.exs")
|> Application.put_all_env()
