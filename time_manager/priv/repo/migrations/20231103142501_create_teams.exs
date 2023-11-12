defmodule TimeManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :team_name, :string
      add :users, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:teams, [:users])
  end
end
