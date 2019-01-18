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
      Map.put(%Vehicle{}, :state, :parked),
      Map.put(%Vehicle{}, :state, :moving),
      Map.put(%Vehicle{}, :state, :unknown),
    ]
    vehicles_parked = vehicles |> UrbanParking.get_parked
    assert Enum.count(vehicles_parked) == 1
  end
end
