defmodule Connecton.Session do
  import Plug.Conn
  alias Connecton.User

  def load_current_user(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    case user do
      nil ->
        conn
      _ ->
        assign(conn, :current_user, user)
    end
  end

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def logged_in?(conn), do: !!conn.assigns[:current_user]

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end
