defmodule TimeManager.TeamsUsers do
  use Ecto.Schema

  schema "teams_users" do

    belongs_to :team, TimeManager.Teams.Team
    belongs_to :user, TimeManager.Users.User

    timestamps(type: :utc_datetime)
  end
end