defmodule Connecton.JobOffer do
  use Connecton.Web, :model

  schema "job_offers" do
    field :title, :string
    field :description, :string
    field :closed_at, Ecto.DateTime
    timestamps

    belongs_to :user, Connecton.User
    has_many :job_offer_skills, Connecton.JobOfferSkill, on_delete: :delete_all
    has_many :skills, through: [:job_offer_skills, :skill]
    has_many :job_applications, Connecton.JobApplication, on_delete: :delete_all
  end

  def active(query) do
    from j in query,
      where: is_nil(j.closed_at)
  end

  def ordered(query) do
    from j in query,
      order_by: [desc: j.inserted_at]
  end

  def with_skill(query, skill_id) do
    from o in query,
      join: s in Connecton.JobOfferSkill,
      where: o.id == s.job_offer_id and s.skill_id == ^skill_id
  end

  def from_user(query, user_id) do
    from j in query,
      where: j.user_id == ^String.to_integer(user_id)
  end

  def not_from_user(query, user_id) do
    from j in query,
      where: j.user_id != ^user_id,
      limit: 5
  end

  @required_fields ~w(title description)
  @optional_fields ~w(closed_at)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def close_changeset(model, _params) do
    model
    |> close()
  end

  def activate_changeset(model, _params) do
    model
    |> activate()
  end

  defp close(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :closed_at, Ecto.DateTime.cast!(:calendar.universal_time()))
      _ ->
        changeset
    end
  end

  defp activate(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :closed_at, nil)
      _ ->
        changeset
    end
  end
end
