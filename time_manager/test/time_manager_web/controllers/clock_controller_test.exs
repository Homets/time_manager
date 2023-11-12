defmodule TimeManagerWeb.ClockControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.ClocksFixtures
  import TimeManager.UsersFixtures
  import TimeManager.Guardian


  @create_attrs %{
    status: true,
    time: ~N[2023-10-24 12:49:00]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "get user clocks" do
    setup [:create_user, :create_clock]

    test "lists all clocks for a user", %{conn: conn, user: user, clock: _clock} do
      {:ok, token, _} = encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(~p"/api/clocks/#{user.id}")

      assert response = json_response(conn, 200)["data"]
      assert length(response) == 1
    end
  end

  describe "create user clock" do
    setup [:create_user]

    test "renders clock when data is valid", %{conn: conn, user: user} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> post(~p"/api/admin/clocks/#{user.id}", clock: @create_attrs)
      assert %{"id" => _id} = json_response(conn, 201)["data"]
    end
  end

  defp create_clock(_) do
    clock = clock_fixture()
    %{clock: clock}
  end
  defp create_user(_) do
    attrs =
    %{
      email: "user@clock.fr",
      username: "test",
      password: "TestPwd"
    }

    user = user_fixture(attrs)
    %{user: user}
  end
end
