defmodule Connecton.User do
  use Connecton.Web, :model

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    timestamps

    has_many :user_skills, Connecton.UserSkill
    has_many :skills, through: [:user_skills, :skill]
    has_many :job_offers, Connecton.JobOffer
    has_many :job_applications, Connecton.JobApplication
    has_many :posts, Connecton.Post
  end

  def full_name(user), do: Enum.join([user.first_name, user.last_name], " ")

  def gravatar(user) do
    hash = :md5
      |> :crypto.hash(user.email)
      |> Base.encode16(case: :lower)
    Enum.join(["http://gravatar.com/avatar/", hash], "")
  end

  def ordered(query) do
    from u in query,
      order_by: [asc: u.email]
  end

  @required_fields ~w(email first_name last_name)
  @optional_fields ~w(password)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
