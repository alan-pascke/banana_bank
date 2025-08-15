defmodule BananaBankWeb.Plugs.Auth do
  alias BananaBankWeb.Token

  import Plug.Conn

  use Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- Plug.Conn.get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      conn
      |> assign(:user_id, data.user_id)
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> put_view(json: BananaBankWeb.ErrorJSON)
        |> render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
