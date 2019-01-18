defmodule UrbanParkingTest.Features.VehicleTest do
  use Cabbage.Feature, async: true, file: "vehicle.feature"
  alias UrbanParking.Vehicle
  alias UrbanParking.Coordinates

  setup do
    %{vehicle: %Vehicle{}}
  end

  defgiven ~r/^A vehicle with "(?<string_1>[^"]+)" state and "(?<string_2>[^"]+)" vin$/, %{string_1: string_1, string_2: string_2}, _state do
    vehicle_state = String.to_atom(string_1)
    vehicle_vin = string_2
    new_state = %{vehicle: %Vehicle{state: vehicle_state, vin: vehicle_vin}}
    {:ok, new_state}
  end

  defgiven ~r/^A vehicle with lat (?<number_1>\d+) lon (?<number_2>\d+) coordinates and "(?<string_1>[^"]+)" vin$/, %{number_1: number_1, number_2: number_2, string_1: string_1}, _state do
    coordinates = %Coordinates{latitude: number_1, longitude: number_2}
    vehicle_vin = string_1
    new_state = %{vehicle: %Vehicle{coordinates: coordinates, vin: vehicle_vin}}
    {:ok, new_state}
  end

  defwhen ~r/^updated with "(?<string_1>[^"]+)" state and "(?<string_2>[^"]+)" vin$/, %{string_1: string_1, string_2: string_2}, state do
    vehicle_state = String.to_atom(string_1)
    vehicle_vin = string_2
    updated_vehicle = %Vehicle{state: vehicle_state, vin: vehicle_vin}
    vehicle = Vehicle.update(state.vehicle, updated_vehicle)
    {:ok, %{vehicle: vehicle}}
  end

  defwhen ~r/^updated with lat (?<number_1>\d+) lon (?<number_2>\d+) coordinates and "(?<string_1>[^"]+)" vin$/, %{number_1: number_1, number_2: number_2, string_1: string_1}, state do
    new_coordinates = %Coordinates{latitude: number_1, longitude: number_2}
    vehicle_vin = string_1
    updated_vehicle = %Vehicle{coordinates: new_coordinates, vin: vehicle_vin}
    vehicle = Vehicle.update(state.vehicle, updated_vehicle)
    {:ok, %{vehicle: vehicle}}
  end

  defthen ~r/^has "(?<string_1>[^"]+)" state$/, %{string_1: string_1}, state do
    vehicle_state = String.to_atom(string_1)
    assert vehicle_state == state.vehicle.state
  end

  defthen ~r/^has update the ping$/, _vars, state do
    vehicle_last_parked_ping = state.vehicle.last_parked_ping
    assert vehicle_last_parked_ping != %Vehicle{}.last_parked_ping
  end

  defthen ~r/^has not update the ping$/, _vars, state do
    vehicle_last_parked_ping = state.vehicle.last_parked_ping
    assert vehicle_last_parked_ping == %Vehicle{}.last_parked_ping
  end

  defthen ~r/^has lat (?<number_1>\d+) lon (?<number_2>\d+) coordinates$/, %{number_1: number_1, number_2: number_2}, state do
    vehicle_coordinates = state.vehicle.coordinates
    assert vehicle_coordinates == %Coordinates{latitude: number_1, longitude: number_2}
  end

end
