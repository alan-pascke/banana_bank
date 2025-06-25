defmodule BananaBank.ViaCep.ClientTest do

  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client, as: ViaCepClient



  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

    describe "call/1" do
      test "succesfully returns cep info", %{bypass: bypass} do
        cep = "82930090"

        body = ~s({
          "cep": "82930-090",
          "logradouro": "",
          "complemento": "",
          "unidade": "",
          "bairro": "Cajuru",
          "localidade": "Curitiba",
          "uf": "PR",
          "estado": "Parana",
          "regiao": "Sul",
          "ibge": "4106902",
          "gia": "",
          "ddd": "41",
          "siafi": "7535"
        })

        expected_response =
          {:ok,
            %{
              "bairro" => "Cajuru",
              "cep" => "82930-090",
              "complemento" => "",
              "ddd" => "41",
              "estado" => "Parana",
              "gia" => "",
              "ibge" => "4106902",
              "localidade" => "Curitiba",
              "logradouro" => "",
              "regiao" => "Sul",
              "siafi" => "7535",
              "uf" => "PR",
              "unidade" => ""
            }
          }

        Bypass.expect(bypass,"GET", "/82930090/json", fn conn ->
          conn
          |> Plug.Conn.put_resp_content_type("application/json")
          |> Plug.Conn.resp(200, body)
        end)

        response =
          bypass.port
          |> endpoint_url()
          |> ViaCepClient.call(cep)

        assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
