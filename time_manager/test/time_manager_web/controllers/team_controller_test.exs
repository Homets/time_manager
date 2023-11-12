defmodule TimeManagerWeb.TeamControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.TeamsFixtures

  alias TimeManager.Teams.Team
  import TimeManager.Guardian
  import TimeManager.UsersFixtures

  @create_attrs %{
    team_name: "con-team"
  }
  @update_attrs %{
    team_name: "con-team-test"
  }
  @invalid_attrs %{team_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teams", %{conn: conn} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(~p"/api/admin/teams")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create team" do
    test "renders team when data is valid", %{conn: conn} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> post(~p"/api/admin/teams", team: @create_attrs)
      assert %{"id" => _id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> post(~p"/api/admin/teams", team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update team" do
    setup [:create_team]

    test "renders team when data is valid", %{conn: conn, team: %Team{id: id} = team} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> put(~p"/api/admin/teams/#{team}", team: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, team: team} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> put(~p"/api/admin/teams/#{team}", team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete team" do
    setup [:create_team]

    test "deletes chosen team", %{conn: conn, team: team} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> delete(~p"/api/admin/teams/#{team}")
        assert conn.status == 200
    end
  end

  defp create_team(_) do
    team = team_fixture()
    %{team: team}
  end
end
