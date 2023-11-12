defmodule TimeManager.WorkingTimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.WorkingTimes` context.
  """

  import TimeManager.UsersFixtures

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    user = user_fixture()

    attrs =
      Enum.into(attrs, %{
        end: ~N[2023-10-24 12:48:00],
        start: ~N[2023-10-24 12:48:00]
      })

    {:ok, working_time} = TimeManager.WorkingTimes.create_working_time(user, attrs)

    working_time
  end
end
