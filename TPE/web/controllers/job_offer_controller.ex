defmodule Connecton.JobOfferController do
  use Connecton.Web, :controller
  import Connecton.Session

  alias Connecton.JobOffer
  alias Connecton.JobOfferSkill
  alias Connecton.JobApplication

  plug Guardian.Plug.EnsureAuthenticated, handler: Connecton.UserSessionController
  plug :scrub_params, "job_offer" when action in [:create, :update]

  def create(conn, %{"job_offer" => job_offer_params}) do
    changeset = JobOffer.changeset(%JobOffer{user_id: current_user(conn).id},
                                   Map.delete(job_offer_params, "skill_ids"))

    case Repo.insert(changeset) do
      {:ok, job_offer} ->
        change_skills(Map.get(job_offer_params, "skill_ids"), job_offer.id)
        conn
        |> redirect(to: job_offer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "index.html", skills: all_skills, offers: all_offers, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    offer = JobOffer
    |> Repo.get!(id)
    |> Repo.preload([:skills, :user, job_applications: [user: :skills]])
    applications = JobApplication
    |> JobApplication.from_offer(String.to_integer(id))
    |> Repo.all
    |> Repo.preload([user: :skills])
    render(conn, "show.html", offer: offer, applications: applications)
  end

  def index(conn, %{"skill_id" => skill_id}) do
    changeset = JobOffer.changeset(%JobOffer{})
    render conn, "index.html", skills: all_skills,
                               offers: filtered_offers(skill_id),
                               changeset: changeset
  end

  def index(conn, _params) do
    changeset = JobOffer.changeset(%JobOffer{})
    render conn, "index.html", skills: all_skills, offers: all_offers, changeset: changeset
  end

  def edit(conn, %{"id" => id}) do
    offer = Repo.get!(JobOffer, id)
    case current_user(conn).id == offer.user_id do
      true ->
        changeset = JobOffer.changeset(offer)
        render(conn, "edit.html", offer: offer, changeset: changeset, skills: all_skills)
      false ->
        redirect(conn, to: job_offer_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "job_offer" => job_offer_params}) do
    offer = Repo.get!(JobOffer, id)
    changeset = JobOffer.changeset(offer, Map.delete(job_offer_params, "skill_ids"))

    case Repo.update(changeset) do
      {:ok, offer} ->
        skills = Map.get(job_offer_params, "skill_ids")
        change_skills(skills, offer.id)
        conn
        |> redirect(to: job_offer_path(conn, :show, offer))
      {:error, changeset} ->
        render(conn, "edit.html", offer: offer, changeset: changeset, skills: all_skills)
    end
  end

  def delete(conn, %{"id" => id}) do
    offer = JobOffer |> Repo.get!(id)
    if current_user(conn).id == offer.user_id do
      Repo.delete!(offer)
    end
    conn
    |> redirect(to: user_path(conn, :show, current_user(conn).id))
  end

  def close(conn, %{"job_offer_id" => id}) do
    offer = JobOffer |> Repo.get!(id)
    if current_user(conn).id == offer.user_id do
      changeset =
        JobOffer.changeset(offer, %{closed_at: Ecto.DateTime.cast!(:calendar.universal_time())})
      Repo.update(changeset)
    end
    conn
    |> redirect(to: user_path(conn, :show, current_user(conn).id))
  end

  def activate(conn, %{"job_offer_id" => id}) do
    offer = JobOffer |> Repo.get!(id)
    if current_user(conn).id == offer.user_id do
      changeset = JobOffer.changeset(offer, %{closed_at: nil})
      Repo.update(changeset)
    end
    conn
    |> redirect(to: user_path(conn, :show, current_user(conn).id))
  end

  defp all_skills, do: Connecton.Skill |> Repo.all

  defp all_offers do
    JobOffer
    |> JobOffer.active
    |> JobOffer.ordered
    |> Repo.all
    |> Repo.preload([:skills, :user])
  end

  defp filtered_offers(skill_id) do
    JobOffer
    |> JobOffer.active
    |> JobOffer.with_skill(skill_id)
    |> JobOffer.ordered
    |> Repo.all
    |> Repo.preload([:skills, :user])
  end

  defp change_skills(nil, job_offer_id), do: delete_offer_skills(job_offer_id)

  defp change_skills(skill_ids, job_offer_id) do
    delete_offer_skills(job_offer_id)
    Enum.map(skill_ids, fn(x) -> create_skill(x, job_offer_id) end)
  end

  defp delete_offer_skills(job_offer_id) do
    JobOfferSkill |> JobOfferSkill.from_job_offer(job_offer_id) |> Repo.delete_all
  end

  defp create_skill(skill_id, job_offer_id) do
    Repo.insert(%JobOfferSkill{skill_id: String.to_integer(skill_id), job_offer_id: job_offer_id})
  end
end
