defmodule Connecton.PostController do
  use Connecton.Web, :controller
  import Connecton.Session

  alias Connecton.Post
  alias Connecton.JobOffer
  alias Guardian.Plug

  plug Guardian.Plug.EnsureAuthenticated, handler: Connecton.UserSessionController
  plug :scrub_params, "post" when action in [:create, :update]

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{user_id: Plug.current_resource(conn).id}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "index.html", posts: all_posts, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Post
    |> Repo.get!(id)
    |> Repo.preload(:user)
    render(conn, "show.html", post: post)
  end

  def index(conn, _params) do
    changeset = Post.changeset(%Post{})
    offers = JobOffer
    |> JobOffer.active
    |> JobOffer.not_from_user(current_user(conn).id)
    |> JobOffer.ordered
    |> Repo.all
    |> Repo.preload([:user, :skills])
    render(conn, "index.html", posts: all_posts, offers: offers, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    case current_user(conn).id == post.user_id do
      true ->
        changeset = Post.changeset(post)
        render(conn, "edit.html", post: post, changeset: changeset)
      false ->
        redirect(conn, to: post_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Post |> Repo.get!(id)
    if current_user(conn).id == post.user_id, do: Repo.delete!(post)
    conn
    |> redirect(to: user_path(conn, :show, current_user(conn).id))
  end

  defp all_posts, do: Post |> Post.ordered |> Repo.all |> Repo.preload(:user)
end
