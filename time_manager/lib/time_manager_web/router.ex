defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router
  alias TimeManager.Guardian
  alias TimeManager.AdminPipeline

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  pipeline :admin do
    plug AdminPipeline
  end

  scope "/auth", TimeManagerWeb do
    pipe_through :api

    post "/register", UserController, :create
    post "/signin", UserController, :signin
  end

  scope "/api", TimeManagerWeb do

    pipe_through [:api, :jwt_authenticated]

      get "/current/user", UserController, :current_user
      get "/users", UserController, :show_user_from_credentials
      get "/clocks/:userID", ClockController, :get_user_clocks
      get "/workingtimes/:userID", WorkingTimeController, :get_user_working_time_range
      get "/workingtimes/:userID/:id", WorkingTimeController, :get_user_working_time
      post "/users", UserController, :edit_current_user
      
    scope "/admin" do
      pipe_through :admin

        resources "/users", UserController, [:index, :update, :delete]
        resources "/clocks", ClockController, [:index, :create]
        resources "/workingtimes", WorkingTimeController, [:index, :update, :delete]
        resources "/teams", TeamController, [:index, :create, :update, :delete]

        post "/workingtimes/:userID", WorkingTimeController, :create_user_working_time
        post "/clocks/:userID", ClockController, :create_user_clock

    end
  end

  if Application.compile_env(:time_manager, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TimeManagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
