defmodule Connecton.Repo.Migrations.CreateModels do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :first_name, :string
      add :last_name, :string

      timestamps
    end

    create unique_index(:users, [:email])

    create table(:skills) do
      add :name, :string, null: false

      timestamps
    end

    create unique_index(:skills, [:name])

    create table(:user_skills) do
      add :user_id, references(:users)
      add :skill_id, references(:skills)
    end

    create table(:posts) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :user_id, references(:users)

      timestamps
    end

    create table(:job_offers) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :closed_at, :datetime
      add :user_id, references(:users)

      timestamps
    end

    create table(:job_offer_skills) do
      add :job_offer_id, references(:job_offers)
      add :skill_id, references(:skills)
    end

    create table(:job_applications) do
      add :description, :text
      add :user_id, references(:users)
      add :job_offer_id, references(:job_offers)

      timestamps
    end

    create unique_index(:job_applications, [:user_id, :job_offer_id])
  end
end
