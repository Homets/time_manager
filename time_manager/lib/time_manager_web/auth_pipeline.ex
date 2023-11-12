defmodule TimeManager.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :time_manager,
  module: TimeManager.Guardian,
  error_handler: TimeManager.AuthErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
