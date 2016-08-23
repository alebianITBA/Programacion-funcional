defmodule Connecton.JobOfferSkill do
  use Connecton.Web, :model

  schema "job_offer_skills" do
    belongs_to :job_offer, Connecton.JobOffer
    belongs_to :skill, Connecton.Skill
  end

  def from_job_offer(query, job_offer_id) do
    from s in query,
      where: s.job_offer_id == ^job_offer_id
  end

end
