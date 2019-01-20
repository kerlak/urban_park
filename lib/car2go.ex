defmodule UrbanParking.Car2go do
  alias UrbanParking.Vehicle

  def get_vehicles do
    vehicles = request_vehicles("LOCATION", "CUSTOMER_TOKEN")
    vehicles |> Enum.map(fn(vehicle) -> Vehicle.from_car2go(vehicle) end)
  end

  def request_vehicles(location, token) do
    url = "https://www.car2go.com/api/v2.1/vehicles?loc="
        <>location
        <>"&oauth_consumer_key="
        <>token
        <>"&format=json"

    %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!(url)
    Poison.Parser.parse!(body)["placemarks"]
  end

end
