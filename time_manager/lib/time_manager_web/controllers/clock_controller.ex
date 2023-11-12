defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clocks
  alias TimeManager.Clocks.Clock
  alias TimeManager.Users
  alias TimeManager.Repo

  action_fallback TimeManagerWeb.FallbackController
  def get_user_clocks(conn, %{"userID" => userID}) do
    clocks = Repo.all(Clock, user_id: userID)

    conn
    |> render(:index, clocks: clocks)
  end
  
  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create_user_clock(conn, %{"userID" => userID} = clock_params) do
    user = Users.get_user!(userID)

    with {:ok, %Clock{} = clock} <- Clocks.create_clock(user, clock_params) do
      conn
      |> put_status(:created)
      |> render(:show, clock: clock)
    end
  end
end
