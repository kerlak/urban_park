defmodule UrbanParking.Vehicle do
  @moduledoc """
  """
  alias UrbanParking.Vehicle
  alias UrbanParking.Coordinates

  defstruct vin: "",
            name: "",
            state: :unknown,
            coordinates: %Coordinates{},
            last_parked_ping: 0,
            type: :none

  def get_spot_info(vehicle) do
    %{coordinates: vehicle.coordinates, released_at: vehicle.last_parked_ping}
  end

  def has_state(vehicle, state) do
    vehicle.state == state
  end

  def update(vehicle, updated_vehicle) do
    case vehicle.vin == updated_vehicle.vin do
      true ->
        vehicle = %Vehicle{vehicle |
          state: updated_vehicle.state,
          coordinates: updated_vehicle.coordinates
        }
        case vehicle.state == :parked do
          true -> %Vehicle{vehicle | last_parked_ping: DateTime.utc_now}
          _ -> vehicle
        end
      _ -> vehicle
    end
  end

  def from_car2go(vehicle) do
    %Vehicle{
      vin: vehicle["vin"],
      name: vehicle["name"],
      coordinates: Coordinates.from_car2go(vehicle["coordinates"]),
      state: :parked,
      last_parked_ping: DateTime.utc_now(),
      type: :car2go
    }
  end

end
