defmodule TimeManager.UsersTest do
  use TimeManager.DataCase

  alias TimeManager.Users

  describe "users" do
    alias TimeManager.Users.User

    import TimeManager.UsersFixtures

    @invalid_attrs %{username: nil, email: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{username: "test2", email: "test2@test.fr", password: Bcrypt.hash_pwd_salt("TestPwd")}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.username == valid_attrs.username
      assert user.email == valid_attrs.email
    refute user.password == "TestPwd"
    assert Bcrypt.verify_pass("TestPwd", user.password)
  end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{username: "test1", email: "test1@test.fr", password: Bcrypt.hash_pwd_salt("TestPwd1")}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.username == update_attrs.username
      assert user.email == update_attrs.email
      refute user.password == "TestPwd1"
      assert Bcrypt.verify_pass("TestPwd1", user.password)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
