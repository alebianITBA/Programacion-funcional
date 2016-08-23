defmodule Connecton.UserSkill do
  use Connecton.Web, :model

  schema "user_skills" do
    belongs_to :user, Connecton.User
    belongs_to :skill, Connecton.Skill
  end

  def from_user(query, user_id) do
    from s in query,
      where: s.user_id == ^user_id
  end

end
