defmodule UrbanParking.VehicleTest do
  use ExUnit.Case
  alias UrbanParking.Vehicle
  alias UrbanParking.Coordinates

  test "get spot information of a vehicle" do
    vehicle = %Vehicle{}
    vehicle = vehicle |> Map.put(:vin, "1234")
    spot_info = vehicle |> Vehicle.get_spot_info
    assert vehicle != spot_info
    assert %{coordinates: _coordinates, released_at: _released_at} = spot_info
  end

  test "parse a car2go vehicle" do
    car2go_vehicle = %{
      "coordinates" => [45, 33, 0],
      "name" => "1234ABC",
      "vin" => "5678"
    }
    now = DateTime.utc_now()
    vehicle = car2go_vehicle |> Vehicle.from_car2go
    vehicle =
      case vehicle.last_parked_ping do
        0 -> vehicle
        _ -> %Vehicle{vehicle | last_parked_ping: now}
      end

    assert vehicle == %Vehicle{
      vin: "5678",
      name: "1234ABC",
      coordinates: %Coordinates{latitude: 33, longitude: 45},
      state: :parked,
      last_parked_ping: now
    }
  end
end
