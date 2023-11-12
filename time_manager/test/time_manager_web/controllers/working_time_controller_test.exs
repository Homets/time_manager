defmodule TimeManagerWeb.WorkingTimeControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.WorkingTimesFixtures
  import TimeManager.UsersFixtures
  import TimeManager.Guardian

  alias TimeManager.WorkingTimes.WorkingTime

  @create_attrs %{
    start: ~N[2023-10-24 12:48:00],
    end: ~N[2023-10-24 12:48:00]
  }
  @update_attrs %{
    start: ~N[2023-10-25 12:48:00],
    end: ~N[2023-10-25 12:48:00]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "get user working times" do
    setup [:create_user, :create_working_time]

    test "lists all workingtimes from a user", %{
      conn: conn,
      user: user,
      working_time: working_time
    } do
      {:ok, token, _} = encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(~p"/api/workingtimes/#{user.id}/#{working_time.id}")

      assert json_response(conn, 200)["data"]
    end
  end

  describe "get user working times range" do
    setup [:create_user, :create_working_time]

    test "lists all working times from a user in start and end range", %{
      conn: conn,
      user: user,
      working_time: working_time
    } do
      start_date = working_time.start
      end_date = working_time.end

      {:ok, token, _} = encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get("/api/workingtimes/#{user.id}?start=#{start_date}&end=#{end_date}")

      assert json_response(conn, 200)["data"]
    end
  end

  describe "create working_time" do
    setup [:create_user]

    test "renders working_time when data is valid", %{conn: conn, user: user} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> post(~p"/api/admin/workingtimes/#{user.id}", working_time: @create_attrs)

      assert %{"id" => _working_time_id} = json_response(conn, 201)["data"]
    end
  end

  describe "update working_time" do
    setup [:create_working_time]

    test "renders working_time when data is valid", %{
      conn: conn,
      working_time: %WorkingTime{id: id} = working_time
    } do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })
      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> put(~p"/api/admin/workingtimes/#{working_time}", working_time: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end
  end

  describe "delete working_time" do
    setup [:create_working_time]

    test "deletes chosen working_time", %{conn: conn, working_time: working_time} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> delete(~p"/api/admin/workingtimes/#{working_time}")

      assert response(conn, 200)
    end
  end

  defp create_working_time(_) do
    working_time = working_time_fixture()
    %{working_time: working_time}
  end

  defp create_user(_) do
    attrs =
      %{
        email: "user@work.fr",
        username: "test",
        password: "TestPwd"
      }

    user = user_fixture(attrs)
    %{user: user}
  end
end
