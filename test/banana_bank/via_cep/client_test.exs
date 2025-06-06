defmodule BananaBank.ViaCep.Client do
  use ExUnit.Case, async: true

  alias Tesla.Client
  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

    describe "call/1" do
      test "succesfully returns cep info", %{bypass: bypass} do
        cep = "82930090"

        body = ~s{
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
        }

        expected_response = "blabla"

        Bypass.expect(bypass, fn conn ->
          conn
          |> Plug.Conn.put_resp_content_type("application/json")
          |> Plug.Conn.resp(200, body)
        end)

        response =
          bypass.port
          |> endpoint_url()
          |> Client.call(cep)

        assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
