defmodule Connecton.UserController do
  use Connecton.Web, :controller
  import Connecton.Session

  alias Connecton.User
  alias Connecton.UserSkill
  alias Connecton.Post
  alias Connecton.JobOffer
  alias Connecton.JobApplication

  plug Guardian.Plug.EnsureAuthenticated, %{handler: Connecton.UserSessionController}
    when action in [:show, :index, :update]
  plug :scrub_params, "user" when action in [:create, :update]

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render(Connecton.PageView, "index.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User
    |> Repo.get!(id)
    |> Repo.preload(:skills)
    posts = Post
    |> Post.ordered
    |> Post.from_user(id)
    |> Repo.all
    offers = JobOffer
    |> JobOffer.from_user(id)
    |> JobOffer.ordered
    |> Repo.all
    |> Repo.preload(:skills)
    applications = JobApplication
    |> JobApplication.from_user(id)
    |> Repo.all
    |> Repo.preload([job_offer: :user])
    render(conn, "show.html", user: user, posts: posts, offers: offers, applications: applications)
  end

  def index(conn, _params) do
    users = User
    |> User.ordered
    |> Repo.all
    |> Repo.preload(:skills)
    render(conn, "index.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    case current_user(conn).id == String.to_integer(id) do
      true ->
        user = Repo.get!(User, id)
        changeset = User.changeset(user)
        render(conn, "edit.html", user: user,
                                  changeset: changeset,
                                  skills: Repo.all(Connecton.Skill))
      false ->
        redirect(conn, to: user_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, Map.delete(user_params, "skill_ids"))

    case Repo.update(changeset) do
      {:ok, user} ->
        change_skills(Map.get(user_params, "skill_ids"), user.id)
        conn
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset,
                                  skills: Repo.all(Connecton.Skill))
    end
  end

  defp change_skills(nil, user_id), do: delete_user_skills(user_id)

  defp change_skills(skill_ids, user_id) do
    delete_user_skills(user_id)
    Enum.map(skill_ids, fn(x) -> create_skill(x, user_id) end)
  end

  defp delete_user_skills(user_id) do
    UserSkill |> UserSkill.from_user(user_id) |> Repo.delete_all
  end

  defp create_skill(skill_id, user_id) do
    Repo.insert(%UserSkill{skill_id: String.to_integer(skill_id), user_id: user_id})
  end
end
