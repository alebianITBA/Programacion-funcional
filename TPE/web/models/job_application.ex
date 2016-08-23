defmodule Connecton.JobApplication do
  use Connecton.Web, :model

  schema "job_applications" do
    field :description, :string
    timestamps

    belongs_to :user, Connecton.User
    belongs_to :job_offer, Connecton.JobOffer
  end

  def from_user(query, user_id) do
    from j in query,
      where: j.user_id == ^user_id
  end

  def from_offer(query, offer_id) do
    from j in query,
      where: j.job_offer_id == ^offer_id
  end

  def from_user_for_offer(query, user_id, job_offer_id) do
    from j in query,
      where: j.user_id == ^user_id and j.job_offer_id == ^job_offer_id
  end

  @required_fields ~w(user_id job_offer_id)
  @optional_fields ~w(description)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:user_id_job_offer_id)
  end
end
