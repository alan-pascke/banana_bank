defmodule BananaBank.ViaCep.Client do
  use Tesla

  @default_url "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  def call(url \\ @default_url, cep) do
    "#{url}/#{cep}/json"
    |> get()
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
