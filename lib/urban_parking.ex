defmodule UrbanParking do
  @moduledoc """
  """
  alias UrbanParking.Vehicle

  defstruct vehicles: []

  def filter_by(vehicles, state) do
    vehicles
    |> Enum.filter(fn(vehicle) -> vehicle |> Vehicle.has_state(state) end)
  end

  def get_parked(vehicles) do
    vehicles |> filter_by(:parked)
  end

  def get_moving(vehicles) do
    vehicles |> filter_by(:moving)
  end

  def get_spots(vehicles) do
    vehicles
    |> get_moving
    |> get_spots_info
  end

  def get_spots_info(vehicles) do
    vehicles
    |> Enum.map(fn(vehicle) -> Vehicle.get_spot_info(vehicle) end)
  end

  def update_vehicles(vehicles, vehicles_with_updates) do
    new_vehicles = get_news(vehicles, vehicles_with_updates)
    updated_vehicles = vehicles_with_updates -- new_vehicles
    vehicles = update_info(vehicles, updated_vehicles)
    vehicles = vehicles ++ new_vehicles
  end

  def get_news(vehicles, vehicles_with_updates) do
    vehicles_with_updates
    |> Enum.filter(fn(updated_vehicle) ->
      vehicles |> Enum.all?(fn(vehicle) ->
        vehicle.vin != updated_vehicle.vin
      end)
    end)
  end

  def update_info(vehicles, updated_vehicles) do
    vehicles
    |> Enum.map(fn(vehicle) ->
      updated_info = updated_vehicles
      |> Enum.find(fn(updated) -> updated.vin == vehicle.vin end)
      case updated_info do
        nil ->
          vehicle
        updated_vehicle ->
          Vehicle.update(vehicle, updated_vehicle)
      end
    end)
  end
end
