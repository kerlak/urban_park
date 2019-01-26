defmodule UrbanParkingTest.Features.Car2goTest do
  use Cabbage.Feature, async: true, file: "car2go.feature"

  alias UrbanParking.Vehicle
  alias UrbanParking.Car2go

  setup do
    %{vehicle: %{}, vehicles: []}
  end

  defgiven ~r/^A "(?<string_1>[^"]+)" vehicle with vin "(?<string_2>[^"]+)"$/, %{string_1: string_1, string_2: string_2}, state do
    vehicle = %Vehicle{vin: string_2, state: String.to_atom(string_1)}
    {:ok, %{state | vehicle: vehicle}}
  end

  defand ~r/^a list of "(?<string_1>[^"]+)" vehicles$/, %{string_1: string_1}, state do
    vehicle_state = String.to_atom(string_1)
    vehicles = [
      %Vehicle{vin: "vehicle_1", state: vehicle_state},
      %Vehicle{vin: "vehicle_2", state: vehicle_state},
      %Vehicle{vin: "vehicle_3", state: vehicle_state},
      %Vehicle{vin: "vehicle_4", state: vehicle_state}
      ]
    {:ok, %{state | vehicles: vehicles}}
  end

  defwhen ~r/^vehicle with vin "(?<vin>[^"]+)" is NOT in vehicles list$/, %{vin: vin}, state do
    vehicles = state.vehicles
    |> Enum.filter(fn(vehicle) -> vehicle.vin != vin end)
    {:ok, %{state | vehicles: vehicles}}
  end

  defand ~r/^update vehicle with vin "(?<string_1>[^"]+)" to moving$/, %{string_1: _string_1}, state do
    vehicle = Car2go.change_to_moving(state.vehicle, state.vehicles)
    {:ok, %{state | vehicle: vehicle}}
  end

  defwhen ~r/^vehicle with vin "(?<vin>[^"]+)" is in vehicles list$/, %{vin: vin}, state do
    vehicles = state.vehicles
    |> Enum.filter(fn(vehicle) -> vehicle.vin != vin end)
    vehicles = vehicles ++ [%Vehicle{vin: vin}]
    {:ok, %{state | vehicles: vehicles}}
  end

  defthen ~r/^vehicle with vin "(?<string_1>[^"]+)" has "(?<string_2>[^"]+)" state$/, %{string_1: string_1, string_2: string_2}, state do
    assert state.vehicle.vin == string_1
    assert state.vehicle.state == String.to_atom(string_2)
  end

  defthen ~r/^vehicle with vin "(?<string_1>[^"]+)" has NOT "(?<string_2>[^"]+)" state$/, %{string_1: string_1, string_2: string_2}, state do
    assert state.vehicle.vin == string_1
    assert state.vehicle.state != String.to_atom(string_2)
  end



end
