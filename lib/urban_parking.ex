defmodule UrbanParking do
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

end
