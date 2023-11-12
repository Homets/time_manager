defmodule TimeManager.AdminPipeline do
    import Plug.Conn
    alias TimeManager.Users.User
  
    def init(_opts) do
      []
    end
  
    def call(conn, _opts) do
      case Guardian.Plug.current_resource(conn) do
        %User{role: "admin"} ->
          conn
        _ ->
          body = Jason.encode!(%{message: "Access forbidden"})
          send_resp(conn, 403, body)
      end
    end
  end
  