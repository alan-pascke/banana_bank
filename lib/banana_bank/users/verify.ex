defmodule BananaBank.Users.Verify do
  alias BananaBank.Users
  alias Users.User

  def call(%{"id" => id, "password" => password}) do
    with {:ok, %User{} = user} <- Users.get(id),
         true <- Pbkdf2.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      _ -> {:error, :unauthorized}
    end  
  end

end
