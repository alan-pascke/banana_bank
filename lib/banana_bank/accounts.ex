defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Create
  # alias BananaBank.Accounts.Delete
  # alias BananaBank.Accounts.Get
  # alias BananaBank.Accounts.Update

  defdelegate create(params), to: Create, as: :call
  # defdelegate get(id), to: Get, as: :call
  # defdelegate update(params), to: Update, as: :call

  # defdelegate delete(user), to: Delete, as: :call
end
