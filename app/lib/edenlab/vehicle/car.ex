defmodule Edenlab.Vehicle.Car do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @body_types [:sedan, :coupe, :pickup]

  schema "cars" do
    field :body_type, Ecto.Enum, values: @body_types

    field :brand_id, Ecto.UUID
    belongs_to :brand, Edenlab.Vehicle.Brand, define_field: false

    field :is_electric, :boolean
    field :model, :string
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:brand_id, :model, :year, :body_type, :is_electric])
    |> validate_required([:brand_id, :model, :year, :body_type, :is_electric])
    |> validate_inclusion(:year, 1886..Date.utc_today.year)
    |> validate_inclusion(:body_type, @body_types)
    |> assoc_constraint(:brand)
  end
end
