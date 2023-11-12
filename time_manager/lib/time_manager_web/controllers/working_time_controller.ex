defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.WorkingTimes
  alias TimeManager.WorkingTimes.WorkingTime
  alias TimeManager.Users
  alias TimeManager.Repo

  action_fallback TimeManagerWeb.FallbackController

  def get_user_working_time_range(conn, %{"userID" => userID, "start" => start, "end" => w_end}) do
    workingtimes = Repo.all(WorkingTime, user_id: userID, start: start, end: w_end)
    conn
    |> render(:index, workingtimes: workingtimes)
  end

  def create_user_working_time(conn, %{"userID" => userID} = params) do
    user = Users.get_user!(userID)

    with {:ok, %WorkingTime{id: _working_time_id} = working_time} <-
           WorkingTimes.create_working_time(user, params) do
      conn
      |> put_status(:created)
      |> render(:show, working_time: working_time)
    end
  end

  def get_user_working_time(conn, %{"userID" => userID, "id" => id}) do
    working_times = Repo.all(WorkingTime, id: id, user_id: userID)

    conn
    |> render(:index, workingtimes: working_times)
  end

  def index(conn, _params) do
    workingtimes = WorkingTimes.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id} = working_time_params) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           WorkingTimes.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
      conn
      |> send_resp(:ok, "deleted")
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = WorkingTimes.get_working_time!(id)
    conn
    |> render(:show, working_time: working_time)
  end

end
