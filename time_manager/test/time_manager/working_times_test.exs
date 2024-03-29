defmodule TimeManager.WorkingTimesTest do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Users` context.
  """
  use TimeManager.DataCase

  alias TimeManager.WorkingTimes

  import TimeManager.UsersFixtures


  describe "workingtimes" do
    alias TimeManager.WorkingTimes.WorkingTime

    import TimeManager.WorkingTimesFixtures

    @invalid_attrs %{start: nil, end: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      working_time = working_time_fixture()
      assert WorkingTimes.list_workingtimes() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert WorkingTimes.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      user = user_fixture()
      valid_attrs = %{start: ~N[2023-10-24 12:48:00], end: ~N[2023-10-24 12:48:00]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimes.create_working_time(user, valid_attrs)
      assert working_time.start == ~N[2023-10-24 12:48:00]
      assert working_time.end == ~N[2023-10-24 12:48:00]
      assert working_time.user_id == user.id
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{start: ~N[2023-10-25 12:48:00], end: ~N[2023-10-25 12:48:00]}

      assert {:ok, %WorkingTime{} = working_time} =
               WorkingTimes.update_working_time(working_time, update_attrs)

      assert working_time.start == ~N[2023-10-25 12:48:00]
      assert working_time.end == ~N[2023-10-25 12:48:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()

      assert {:error, %Ecto.Changeset{}} =
               WorkingTimes.update_working_time(working_time, @invalid_attrs)

      assert working_time == WorkingTimes.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = WorkingTimes.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimes.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = WorkingTimes.change_working_time(working_time)
    end
  end
end
