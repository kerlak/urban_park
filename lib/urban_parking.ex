defmodule UrbanParking do
  @moduledoc """
  Documentation for UrbanParking.
  """

  @doc """
  Hello world.

  ## Examples
      iex> UrbanParking.hello
      :world
  """
  def hello do
    :world
  end

  def get_spots(previous_parked, current_parked) do
    previous_parked |> Enum.filter(fn(vin) -> vin not in current_parked end)
  end
end
