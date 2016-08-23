defmodule Connecton.PageController do
  use Connecton.Web, :controller

  alias Connecton.User

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "index.html", changeset: changeset
  end
end
