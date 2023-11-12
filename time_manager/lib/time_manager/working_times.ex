defmodule TimeManager.WorkingTimes do
  @moduledoc """
  The Clocks context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.WorkingTimes.WorkingTime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%WorkingTime{}, ...]

  """
  def list_workingtimes( id \\ 0) do
    case id do
      0 -> 
        Repo.all(WorkingTime)
        |> Repo.preload([:user])
      _ -> 
        Repo.all(from working_time in TimeManager.WorkingTimes.WorkingTime, where: working_time.user_id == ^id)
        |> Repo.preload([:user])
    end
  end
  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the WorkingTime does not exist.

  ## Examples

      iex> get_working_time!(123)
      %WorkingTime{}

      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time!(id) do 
    Repo.get!(WorkingTime, id)
    |>Repo.preload([:user])
  end
  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(user,attrs \\ %{}) do
    working_time = %WorkingTime{}
            |> WorkingTime.changeset(attrs)
            |> Ecto.Changeset.apply_changes()
   
    Ecto.build_assoc(user, :working_time, working_time)
      |> Repo.preload([:user])
      |> Repo.insert()

  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end
