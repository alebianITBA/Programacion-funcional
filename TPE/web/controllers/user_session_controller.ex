defmodule Connecton.UserSessionController do
  use Connecton.Web, :controller

  alias Connecton.User

  def login(conn, %{"session" => session_params}) do
    case Connecton.Session.login(session_params, Connecton.Repo) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: post_path(conn, :index))
      :error ->
        conn
        |> render(Connecton.PageView, "index.html", changeset: User.changeset(%User{}))
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/")
  end

  def unauthenticated(conn, _params) do
    conn
    |> redirect(to: "/")
  end
end
