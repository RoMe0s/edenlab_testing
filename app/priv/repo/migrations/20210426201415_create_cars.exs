defmodule Edenlab.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :brand_id, references("brands", type: :uuid, on_delete: :delete_all)
      add :model, :string
      add :year, :integer
      add :body_type, :string
      add :is_electric, :boolean, null: false

      timestamps()
    end

    create index(:cars, [:brand_id, :body_type, :is_electric])
    create index(:cars, [:is_electric])
  end
end
