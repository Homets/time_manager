defmodule TimeManager.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Clocks` context.
  """
  import TimeManager.UsersFixtures

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    user = user_fixture()
    attrs =
      Enum.into(attrs, %{
      status: true,
      time: ~N[2023-10-24 12:49:00],
    })
    {:ok, clock} = TimeManager.Clocks.create_clock(user, attrs)

    clock
  end
end
