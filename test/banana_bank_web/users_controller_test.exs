defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.Users
  alias BananaBank.Users.{User}
  use BananaBankWeb.ConnCase

  describe "create/1" do
    test "when all params are valid, returns the user", %{conn: conn} do
      params = %{
        name: "Julius",
        cep: "12345678",
        email: "julius@email.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert  %{
        "data" => %{"cep" => "12345678", "email" => "julius@email.com", "id" => _id, "name" => "Julius"},
        "message" => "User created"
      } = response
    end
  end

  describe "update/1" do
    test "Update user", %{conn: conn} do
      params = %{
        name: "Johnson",
        cep: "12345678",
        email: "johnson@email.com",
        password: "123456"
      }

      {:ok, %User{id: id}} = Users.create(params)

      new_params = %{
        name: "Jin",
        email: "jin@email.com",
      }

      response =
        conn
        |> put(~p"/api/users/#{id}", new_params)
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"cep" => "12345678", "email" => "jin@email.com", "id" => id, "name" => "Jin"},
        "message" => "User updated"
      }

      assert response == expected_response
    end
  end
end
