defmodule TimeManager.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "test@test.fr",
        username: "test",
        password: Bcrypt.hash_pwd_salt("TestPwd")
      })
      |> TimeManager.Users.create_user()

    user
  end
end
