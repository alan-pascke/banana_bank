defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User
  def create(%{user: user}) do
    %{
      message: "User created",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  def update(%{user: user}), do: %{message: "User updated", data: data(user)}

  def delete(%{user: user}), do: %{message: "User deleted", data: data(user)}


  defp data (%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      cep: user.cep,
      email: user.email
    }

  end
end
