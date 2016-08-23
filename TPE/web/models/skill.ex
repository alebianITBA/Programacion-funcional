defmodule Connecton.Skill do
  use Connecton.Web, :model

  schema "skills" do
    field :name, :string
    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
