defmodule UrbanParking.Coordinates do
  @moduledoc """
  """
  alias UrbanParking.Coordinates
  
  defstruct latitude: 0, longitude: 0

  def from_car2go(coordinates) do
    latitude = coordinates |> Enum.at(1)
    longitude = coordinates |> Enum.at(0)
    %Coordinates{latitude: latitude, longitude: longitude}
  end
end
