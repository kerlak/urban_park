defmodule UrbanParking.VehicleTest do
  use ExUnit.Case
  alias UrbanParking.Vehicle

  test "get spot information of a vehicle" do
    vehicle = %Vehicle{}
    vehicle = vehicle |> Map.put(:vin, "1234")
    spot_info = vehicle |> Vehicle.get_spot_info
    assert vehicle != spot_info
    assert %{coordinates: coordinates, released_at: released_at} = spot_info
  end
end
