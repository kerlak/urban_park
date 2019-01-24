defmodule UrbanParking.Car2go do
  @moduledoc """
  """
  alias UrbanParking.Vehicle
  alias Poison.Parser

  @location Application.get_env(:urban_parking, :car2go_location, "LOCATION")
  @customer_key Application.get_env(:urban_parking, :car2go_customer_key, "CUSTOMER_KEY")

  def get_vehicles do
    vehicles = request_vehicles(@location, @customer_key)
    vehicles |> Enum.map(fn(vehicle) -> Vehicle.from_car2go(vehicle) end)
  end

  def request_vehicles(location, token) do
    url = "https://www.car2go.com/api/v2.1/vehicles?loc="
        <> location
        <> "&oauth_consumer_key="
        <> token
        <> "&format=json"

    %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!(url)
    Parser.parse!(body)["placemarks"]
  end
end
