defmodule UrbanParking.Vehicle do
  alias UrbanParking.Vehicle
  alias UrbanParking.Coordinates

  defstruct vin: "", name: "", state: :unknown, coordinates: %Coordinates{}, last_parked_ping: 0

  def get_spot_info(vehicle) do
    %{coordinates: vehicle.coordinates, released_at: vehicle.last_parked_ping}
  end

  def has_state(vehicle, state) do
    vehicle.state == state
  end

end
