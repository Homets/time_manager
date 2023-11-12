defmodule TimeManager.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :team_name, :string
    
    many_to_many :user, TimeManager.Users.User,
      join_through: TimeManager.TeamsUsers

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:team_name])
    |> validate_required([:team_name])
  end
end
