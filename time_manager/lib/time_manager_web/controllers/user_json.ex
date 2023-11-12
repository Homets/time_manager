defmodule TimeManagerWeb.UserJSON do
  alias TimeManager.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end
  @doc """
  Renders a single error.
  """
  def error(%{message: message}) do
    %{data: data_msg(message)}
  end

  @doc """
  Renders a single token.
  """
  def show_token(%{token: token}) do
    %{data: data_token(token)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role
    }
  end
  defp data_token(token) do
    %{
      token: token
    }
  end
  defp data_msg(message) do
    %{
      error: message
    }
  end
end
