defmodule UrbanParkingTest.Features.UrbanParkingTest do
  use Cabbage.Feature, async: false, file: "urban_parking.feature"

  setup do
    %{}
  end

  defgiven ~r/^Nothing implemented yet$/, _vars, state do
    # Your implementation here
  end

  defwhen ~r/^request for realeased spaces$/, _vars, state do
    # Your implementation here
    {:ok, %{spaces: []}}
  end

  defthen ~r/^return an empty list$/, _vars, state do
    # Your implementation here
    %{spaces: spaces} = state
    assert spaces |> is_list
    assert spaces |> Enum.empty?
  end

end
