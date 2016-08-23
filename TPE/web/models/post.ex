defmodule Connecton.Post do
  use Connecton.Web, :model

  schema "posts" do
    field :title, :string
    field :description, :string
    timestamps

    belongs_to :user, Connecton.User
  end

  def ordered(query) do
    from p in query,
      order_by: [desc: p.inserted_at]
  end

  def from_user(query, user_id) do
    from p in query,
      where: p.user_id == ^String.to_integer(user_id)
  end

  @required_fields ~w(title description user_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
