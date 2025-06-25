defmodule BananaBank.ViaCep.Client do
  alias BananaBank.ViaCep.ClientBehaviour

  @default_url "https://viacep.com.br/ws"

  @behaviour ClientBehaviour

  @impl ClientBehaviour
  def call(url \\ @default_url, cep) do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, @default_url},
      Tesla.Middleware.JSON,
     ])
    |> Tesla.get("#{url}/#{cep}/json")
    |> handle_reponse()
  end

  defp handle_reponse({:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}}) do
    {:error, :not_found}
  end

  defp handle_reponse({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_reponse({:ok, %Tesla.Env{status: 400}}) do
    {:error, :bad_request}
  end

  defp handle_reponse({:ok, _}) do
    {:error, :internal_server}
  end
end
