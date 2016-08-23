defmodule Connecton.JobApplicationController do
  use Connecton.Web, :controller
  import Connecton.Session

  plug Guardian.Plug.EnsureAuthenticated, handler: Connecton.UserSessionController

  alias Connecton.JobApplication

  def delete(conn, %{"id" => id}) do
    application = JobApplication
    |> Repo.get!(id)

    if current_user(conn).id == application.user_id, do: Repo.delete!(application)

    conn
    |> redirect(to: user_path(conn, :show, current_user(conn).id))
  end

  def apply_from_posts(conn, %{"job_offer_id" => job_offer_id}) do
    application = JobApplication
    |> JobApplication.from_user_for_offer(current_user(conn).id, String.to_integer(job_offer_id))
    |> Repo.one

    unless application do
      Repo.insert %JobApplication{user_id: current_user(conn).id,
                                  job_offer_id: String.to_integer(job_offer_id)}
    end

    conn
      |> redirect(to: post_path(conn, :index))
  end
end
