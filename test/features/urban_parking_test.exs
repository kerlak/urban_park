defmodule UrbanParkingTest.Features.UrbanParkingTest do
  use Cabbage.Feature, async: false, file: "urban_parking.feature"

  setup do
    %{previous_parked: [], current_parked: []}
  end

  defgiven ~r/^Nothing implemented yet$/, _vars, _state do
    # Your implementation here
  end

  defwhen ~r/^request for realeased spots$/, _vars, state do
    # Your implementation here
    %{previous_parked: previous_parked, current_parked: current_parked} = state
    spots = UrbanParking.get_spots(previous_parked, current_parked)
    {:ok, %{spots: spots}}
  end

  defthen ~r/^return an empty list$/, _vars, state do
    # Your implementation here
    %{spots: spots} = state
    assert spots |> is_list
    assert spots |> Enum.empty?
  end

end
