defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase, async: true
  import Mox

  alias BananaBank.Users
  alias Users.User

  setup :verify_on_exit!

  setup do
    params = %{
      "name" => "Julius",
      "cep" => "82930090",
      "email" => "julius@email.com",
      "password" => "123456"
    }

    body = %{
      "cep" => "82930-090",
      "logradouro" => "",
      "complemento" => "",
      "unidade" => "",
      "bairro" => "Cajuru",
      "localidade" => "Curitiba",
      "uf" => "PR",
      "estado" => "Parana",
      "regiao" => "Sul",
      "ibge" => "4106902",
      "gia"=> "",
      "ddd" => "41",
      "siafi" => "7535"
    }
    {:ok, %{user_params: params, body: body}}
  end

  describe "create/2" do
    test "when all params are valid, returns the user", %{conn: conn, body: body, user_params: params} do

      expect(BananaBank.ViaCep.ClientMock, :call, fn "82930090" -> {:ok, body} end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert  %{
        "data" => %{"cep" => "82930090", "email" => "julius@email.com", "id" => _id, "name" => "Julius"},
        "message" => "User created"
      } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        "name" => nil,
        "cep" => "12",
        "email" => "julius@email.com",
        "password" => "123456"
      }

      expect(BananaBank.ViaCep.ClientMock, :call, fn "12" -> {:ok, ""} end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expect_response = %{
        "errors" => %{
          "cep" => ["should be 8 character(s)"],
          "name" => ["can't be blank"]
        }
      }

      assert response == expect_response
    end
  end

  describe "update/1" do
    test "Update user", %{conn: conn, body: body, user_params: params } do

      expect(BananaBank.ViaCep.ClientMock, :call, fn "82930090" -> {:ok, body} end)

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
        "data" => %{"cep" => "82930090", "email" => "jin@email.com", "id" => id, "name" => "Jin"},
        "message" => "User updated"
      }

      assert response == expected_response
    end
  end
end
