defmodule UrbanParkingTest do
  use ExUnit.Case
  alias UrbanParking.Vehicle
  doctest UrbanParking

  test "get spots must return an empty list on first call" do
    vehicles = []
    assert UrbanParking.get_spots(vehicles) == []
  end

  test "get only parked vehicles from a list of vehicles" do
    vehicles = [
      %Vehicle{state: :parked},
      %Vehicle{state: :moving},
      %Vehicle{state: :unknown}
    ]
    vehicles_parked = vehicles |> UrbanParking.get_parked
    assert Enum.count(vehicles_parked) == 1
  end

  test "get only new vehicles between two lists" do
    vehicles = [
      %Vehicle{vin: "1234"},
      %Vehicle{vin: "5678"}
    ]
    updated_vehicles = [
      %Vehicle{vin: "1234"},
      %Vehicle{vin: "5678"},
      %Vehicle{vin: "9012"}
    ]
    new_vehicles = UrbanParking.get_news(vehicles, updated_vehicles)
    assert new_vehicles == [%Vehicle{vin: "9012"}]
  end
end
