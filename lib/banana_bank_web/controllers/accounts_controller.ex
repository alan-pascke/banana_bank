defmodule BananaBankWeb.AccountsController do
  use BananaBankWeb, :controller

  alias BananaBank.Accounts
  alias Accounts.Account

  action_fallback BananaBankWeb.FallBackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Account{} = account} <- Accounts.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, result} <- Accounts.transaction(params) do
      conn
      |> put_status(:ok)
      |> render(:transaction, transaction: result)
    end
  end


  # def update(conn, params) do
  #   with {:ok, %Account{} = account} <- Accounts.update(params) do
  #     conn
  #     |> put_status(:ok)
  #     |> render(:update, account: account)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   with {:ok, %Account{} = account} <- Accounts.delete(id) do
  #     conn
  #     |> put_status(:ok)
  #     |> render(:delete, account: account)
  #   end
  # end


end
