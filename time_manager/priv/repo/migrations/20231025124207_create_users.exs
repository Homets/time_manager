defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :role, :string
      add :is_manager, :boolean

      timestamps(type: :utc_datetime)
    end
    execute("CREATE UNIQUE INDEX unique_email_index ON users (email);")
  end
end
