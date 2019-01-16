defmodule UrbanParkingTest do
  use ExUnit.Case
  doctest UrbanParking

  test "greets the world" do
    assert UrbanParking.hello() == :world
  end

  test "get spots must return an empty list on first call" do
    previous_parked = []
    current_parked = []
    assert UrbanParking.get_spots(previous_parked, current_parked) == []
  end

  test "get released spots from those that were previously occupied" do
    previous_parked = [%{vin: 1234}, %{vin: 5678}]
    current_parked = [%{vin: 1234}, %{vin: 0000}]
    assert UrbanParking.get_spots(previous_parked, current_parked) == [%{vin: 5678}]
  end

  # test "get vehicles add new vehicles" do
  #
  # end
end
