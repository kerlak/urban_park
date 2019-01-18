defmodule UrbanParkingTest.Features.UrbanParkingTest do
  use Cabbage.Feature, async: true, file: "urban_parking.feature"

  alias UrbanParking.Vehicle

  setup do
    %{vehicles: []}
  end

  defgiven ~r/^Nothing implemented yet$/, _vars, _state do
  end

  defgiven ~r/^A list of vehicles$/, _vars, _state do
    state = %{vehicles: [
      %Vehicle{vin: "vehicle_1", state: :parked},
      %Vehicle{vin: "vehicle_2", state: :parked},
      %Vehicle{vin: "vehicle_3", state: :moving},
      %Vehicle{vin: "vehicle_4", state: :unknown}
      ]}
    {:ok, state}
  end

  defwhen ~r/^request for realeased spots$/, _vars, state do
    %{vehicles: vehicles} = state
    spots = UrbanParking.get_spots(vehicles)
    {:ok, %{spots: spots}}
  end

  defwhen ~r/^request for vehicles updates$/, _vars, state do
    responsed_vehicles = [
      %Vehicle{vin: "vehicle_3", state: :parked},
      %Vehicle{vin: "vehicle_4", state: :moving},
      %Vehicle{vin: "vehicle_5"}
    ]
    updated_vehicles = state.vehicles |> UrbanParking.update_vehicles(responsed_vehicles)
    {:ok, %{vehicles: updated_vehicles}}
  end

  defthen ~r/^return an empty list$/, _vars, state do
    %{spots: spots} = state
    assert spots |> is_list
    assert spots |> Enum.empty?
  end

  defthen ~r/^the list of vehicles have the new ones$/, _vars, state do
    assert state.vehicles
      |> Enum.filter(fn(vehicle) -> vehicle.vin == "vehicle_5" end)
      |> Enum.count
      == 1
  end

  defthen ~r/^the existing vehicles update its information$/, _vars, state do
    assert state.vehicles
      |> Enum.any?(fn(vehicle) ->
        vehicle.vin == "vehicle_3" and vehicle.state == :parked
      end)
    assert state.vehicles
      |> Enum.any?(fn(vehicle) ->
        vehicle.vin == "vehicle_4" and vehicle.state == :moving
      end)
  end

end
