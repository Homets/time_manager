defmodule TimeManagerWeb.UserControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.UsersFixtures
  import TimeManager.Guardian

  alias TimeManager.Users.User

  @create_attrs %{
    username: "username",
    email: "example@email.com",
    password: "ConTestPwd"
  }
  @update_attrs %{
    username: "username1",
    email: "example1@email.com",
    password: "ConTestPwd1"
  }
  @invalid_attrs %{username: nil, email: nil, password: "NilTest", role: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_user]
    test "lists searched user of proviede username and email", %{conn: conn, user: user} do
      {:ok, token, _} = encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(~p"/api/users?email=#{user.email}&username=#{user.username}")
      assert json_response(conn, 200)["data"]
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      user = @create_attrs
      conn = post(conn, ~p"/auth/register", user: user)
      assert %{"id" => _id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/auth/register", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "get user" do
    setup [:create_user]

    test "renders chosen user data", %{conn: conn, user: user} do
      user_to_find = user_fixture(%{
        username: "yousearched",
        email: "you@searched.com",
        password: "YouSearched"
      })
      {:ok, token, _} = encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(~p"/api/users?username=#{user_to_find.username}&email=#{user_to_find.email}")

      assert [%{
               "email" => "you@searched.com",
               "username" => "yousearched"
             }] = json_response(conn, 200)["data"]
    end
  end

  describe "get current user" do
    setup [:create_user]

    test "renders current user data", %{conn: conn, user: user} do
      {:ok, token, _} = encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(~p"/api/current/user")

      assert %{
               "email" => "test@test.fr",
               "username" => "test"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "signin" do
    setup [:create_user]

    test "signs in and returns a token when credentials are valid", %{conn: conn, user: user} do
      conn =
        post(conn, ~p"/auth/signin", %{
          email: user.email,
          password: "TestPwd"
        })

      assert json_response(conn, 200)["data"]["token"]
    end

    test "returns an error when credentials are invalid", %{conn: conn, user: user} do
      conn =
        post(conn, ~p"/auth/signin", %{
          email: user.email,
          password: "wrongpassword"
        })

      assert json_response(conn, 401)["data"]["error"] ==
               "Failed to sign in, invalid credentials."
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> put(~p"/api/admin/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      admin_user = user_fixture(%{
        email: "test_admin@admin.fr",
        password: "TestPwdAdmin",
        role: "admin"
      })

      {:ok, token, _} = encode_and_sign(admin_user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> delete(~p"/api/admin/users/#{user}")
        assert conn.status == 200
        assert conn.resp_body == "deleted"
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
