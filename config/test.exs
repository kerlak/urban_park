use Mix.Config

config :urban_parking,
  car2go_customer_key: System.get_env("car2go_key"),
  car2go_location: "Madrid"
