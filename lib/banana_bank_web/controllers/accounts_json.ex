defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account
  def create(%{account: account}) do
    %{
      message: "Account created",
      data: data(account)
    }
  end

  def get(%{account: account}), do: %{data: data(account)}

  def transaction(%{transaction: %{withdraw: from_account, deposit: to_account}}) do
    %{
      message: "Transaction was successfull",
      from_account: data(from_account),
      to_account: data(to_account)
    }
  end

  defp data (%Account{} = account) do
    %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
    }
  end

end
