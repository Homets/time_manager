defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Users
  alias TimeManager.Users.User
  alias TimeManager.Repo
  alias TimeManager.Guardian

  action_fallback TimeManagerWeb.FallbackController

  def show_user_from_credentials(conn, params) do
    users =
      if Map.has_key?(params, "email") and Map.has_key?(params, "username") do
        username = params["username"]
        email = params["email"]
        user = Repo.get_by(User, username: username, email: email)

        if user do
          List.insert_at([], 0, user)
        else
          []
        end
      else
        []
      end

    conn
    |> put_status(:ok)
    |> render(:index, users: users)
  end

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    updated_user_params =
      Map.put(user_params, "password", Bcrypt.hash_pwd_salt(user_params["password"]))

    with {:ok, %User{} = user} <- Users.create_user(updated_user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def update(conn, %{"id" => id} = user_params) do
    user = Users.get_user!(id)

    updated_user_params =
      if Map.has_key?(user_params, "password") do
        Map.put(user_params, "password", Bcrypt.hash_pwd_salt(user_params["password"]))
      else
        user_params
      end

    case Users.update_user(user, updated_user_params) do
      {:ok, updated_user} ->
        conn
        |> put_status(:ok)
        |> render(:show, user: updated_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      conn
      |> send_resp(:ok, "deleted")
    end
  end


  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    conn
    |> render(:show, user: user)
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> render(:error, message: "Failed to sign in, user not fount.")

      user ->
        if Bcrypt.verify_pass(password, user.password) do
          case Guardian.encode_and_sign(user, %{}) do
            {:ok, token, _claims} ->
              conn
              |> put_status(:ok)
              |> render("show_token.json", token: token)

            {:error, _reason} ->
              conn
              |> put_status(:unauthorized)
              |> render(:error, message: "Failed to sign in, failed to issue token.")
          end
        else
          conn
          |> put_status(:unauthorized)
          |> render(:error, message: "Failed to sign in, invalid credentials.")
        end
    end
  end

  def current_user(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> render(:show, user: user)
  end

  def edit_current_user(conn, user_params) do
    user = Guardian.Plug.current_resource(conn)
    updated_user_params =
      if Map.has_key?(user_params, "password") do
        Map.put(user_params, "password", Bcrypt.hash_pwd_salt(user_params["password"]))
      else
        user_params
      end

    case Users.update_user(user, updated_user_params) do
      {:ok, updated_user} ->
        conn
        |> put_status(:ok)
        |> render(:show, user: updated_user)
    end
  end
end
