# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Connecton.Repo.insert!(%Connecton.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Connecton.Repo
alias Connecton.User
alias Connecton.JobOffer
alias Connecton.Post
alias Connecton.JobOfferSkill
alias Connecton.UserSkill
alias Connecton.JobApplication

Repo.insert! %User{email: "alebezdjian@gmail.com", first_name: "Alejandro", last_name: "Bezdjian", password_hash: Comeonin.Bcrypt.hashpwsalt("test")}
Repo.insert! %User{email: "test1@gmail.com", first_name: "Test", last_name: "One", password_hash: Comeonin.Bcrypt.hashpwsalt("test")}
Repo.insert! %User{email: "test2@gmail.com", first_name: "Test", last_name: "Two", password_hash: Comeonin.Bcrypt.hashpwsalt("test")}
Repo.insert! %User{email: "test3@gmail.com", first_name: "Test", last_name: "Three", password_hash: Comeonin.Bcrypt.hashpwsalt("test")}

Repo.insert! %JobOffer{title: "Oferta prueba 1", description: "Esto es una prueba", user_id: 1}
Repo.insert! %JobOffer{title: "Oferta prueba 2", description: "Esto es una prueba", user_id: 1}
Repo.insert! %JobOffer{title: "Oferta prueba 3", description: "Esto es una prueba", user_id: 2}
Repo.insert! %JobOffer{title: "Oferta prueba 4", description: "Esto es una prueba", user_id: 2}
Repo.insert! %JobOffer{title: "Oferta prueba 5", description: "Esto es una prueba", user_id: 3}
Repo.insert! %JobOffer{title: "Oferta prueba 6", description: "Esto es una prueba", user_id: 3}
Repo.insert! %JobOffer{title: "Oferta prueba 7", description: "Esto es una prueba", user_id: 4}
Repo.insert! %JobOffer{title: "Oferta prueba 8", description: "Esto es una prueba", user_id: 4}

Repo.insert! %Post{title: "Post prueba 1", description: "Esto es una prueba", user_id: 1}
Repo.insert! %Post{title: "Post prueba 2", description: "Esto es una prueba", user_id: 1}
Repo.insert! %Post{title: "Post prueba 3", description: "Esto es una prueba", user_id: 2}
Repo.insert! %Post{title: "Post prueba 4", description: "Esto es una prueba", user_id: 2}
Repo.insert! %Post{title: "Post prueba 5", description: "Esto es una prueba", user_id: 3}
Repo.insert! %Post{title: "Post prueba 6", description: "Esto es una prueba", user_id: 3}
Repo.insert! %Post{title: "Post prueba 7", description: "Esto es una prueba", user_id: 4}
Repo.insert! %Post{title: "Post prueba 8", description: "Esto es una prueba", user_id: 4}

Repo.insert! %JobOfferSkill{job_offer_id: 1, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 1, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 1, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 1, skill_id: 4}
Repo.insert! %JobOfferSkill{job_offer_id: 2, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 2, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 2, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 2, skill_id: 4}
Repo.insert! %JobOfferSkill{job_offer_id: 3, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 3, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 3, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 3, skill_id: 4}
Repo.insert! %JobOfferSkill{job_offer_id: 4, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 4, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 4, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 4, skill_id: 4}
Repo.insert! %JobOfferSkill{job_offer_id: 5, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 5, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 5, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 5, skill_id: 4}
Repo.insert! %JobOfferSkill{job_offer_id: 6, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 6, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 6, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 6, skill_id: 4}
Repo.insert! %JobOfferSkill{job_offer_id: 7, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 7, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 7, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 7, skill_id: 4}
Repo.insert! %JobOfferSkill{job_offer_id: 8, skill_id: 1}
Repo.insert! %JobOfferSkill{job_offer_id: 8, skill_id: 2}
Repo.insert! %JobOfferSkill{job_offer_id: 8, skill_id: 3}
Repo.insert! %JobOfferSkill{job_offer_id: 8, skill_id: 4}

Repo.insert! %UserSkill{user_id: 1, skill_id: 1}
Repo.insert! %UserSkill{user_id: 1, skill_id: 2}
Repo.insert! %UserSkill{user_id: 1, skill_id: 3}
Repo.insert! %UserSkill{user_id: 1, skill_id: 4}
Repo.insert! %UserSkill{user_id: 2, skill_id: 1}
Repo.insert! %UserSkill{user_id: 2, skill_id: 2}
Repo.insert! %UserSkill{user_id: 2, skill_id: 3}
Repo.insert! %UserSkill{user_id: 2, skill_id: 4}
Repo.insert! %UserSkill{user_id: 3, skill_id: 1}
Repo.insert! %UserSkill{user_id: 3, skill_id: 2}
Repo.insert! %UserSkill{user_id: 3, skill_id: 3}
Repo.insert! %UserSkill{user_id: 3, skill_id: 4}
Repo.insert! %UserSkill{user_id: 4, skill_id: 1}
Repo.insert! %UserSkill{user_id: 4, skill_id: 2}
Repo.insert! %UserSkill{user_id: 4, skill_id: 3}
Repo.insert! %UserSkill{user_id: 4, skill_id: 4}

Repo.insert! %JobApplication{user_id: 1, job_offer_id: 3, description: "nada"}
Repo.insert! %JobApplication{user_id: 1, job_offer_id: 4, description: "nada"}
Repo.insert! %JobApplication{user_id: 1, job_offer_id: 5, description: "nada"}
Repo.insert! %JobApplication{user_id: 1, job_offer_id: 6, description: "nada"}
Repo.insert! %JobApplication{user_id: 1, job_offer_id: 7, description: "nada"}
Repo.insert! %JobApplication{user_id: 1, job_offer_id: 8, description: "nada"}

Repo.insert! %JobApplication{user_id: 2, job_offer_id: 1, description: "nada"}
Repo.insert! %JobApplication{user_id: 2, job_offer_id: 2, description: "nada"}
Repo.insert! %JobApplication{user_id: 2, job_offer_id: 5, description: "nada"}
Repo.insert! %JobApplication{user_id: 2, job_offer_id: 6, description: "nada"}
Repo.insert! %JobApplication{user_id: 2, job_offer_id: 7, description: "nada"}
Repo.insert! %JobApplication{user_id: 2, job_offer_id: 8, description: "nada"}

Repo.insert! %JobApplication{user_id: 3, job_offer_id: 3, description: "nada"}
Repo.insert! %JobApplication{user_id: 3, job_offer_id: 4, description: "nada"}
Repo.insert! %JobApplication{user_id: 3, job_offer_id: 1, description: "nada"}
Repo.insert! %JobApplication{user_id: 3, job_offer_id: 2, description: "nada"}
Repo.insert! %JobApplication{user_id: 3, job_offer_id: 7, description: "nada"}
Repo.insert! %JobApplication{user_id: 3, job_offer_id: 8, description: "nada"}

Repo.insert! %JobApplication{user_id: 4, job_offer_id: 3, description: "nada"}
Repo.insert! %JobApplication{user_id: 4, job_offer_id: 4, description: "nada"}
Repo.insert! %JobApplication{user_id: 4, job_offer_id: 5, description: "nada"}
Repo.insert! %JobApplication{user_id: 4, job_offer_id: 6, description: "nada"}
Repo.insert! %JobApplication{user_id: 4, job_offer_id: 1, description: "nada"}
Repo.insert! %JobApplication{user_id: 4, job_offer_id: 2, description: "nada"}
