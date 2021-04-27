defmodule Edenlab.VehicleTest do
  use Edenlab.DataCase

  alias Edenlab.Repo
  alias Edenlab.Vehicle
  alias Edenlab.Vehicle.Brand

  describe "cars" do
    alias Edenlab.Vehicle.Car

    @brand_attrs %{name: "BMW"}

    @valid_attrs %{body_type: :sedan, model: "test model", year: 1990, is_electric: false}
    @invalid_attrs %{body_type: "random string", brand_id: nil, id: nil, is_electric: nil, model: nil, year: nil}

    def brand_fixture(attrs \\ %{}) do
      result = %Brand{}
        |> Brand.changeset(Enum.into(attrs, @brand_attrs))
        |> Repo.insert()

      case result do
        {:ok, brand} -> brand
        _ -> Repo.get_by(Vehicle, name: attrs.name)
      end
    end

    def car_fixture(attrs \\ %{}) do
      attrs =
        unless Map.has_key?(attrs, :brand_id) do
          %Brand{id: brand_id} = brand_fixture()
          Map.put(attrs, :brand_id, brand_id)
        else
          attrs
        end

      {:ok, car} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vehicle.create_car()

      car
    end

    test "list_cars/1 with no filters returns all cars" do
      car = car_fixture()
      assert Vehicle.list_cars([]) == [car]
    end

    test "list_cars/1 with brand filter returns valid car" do
      car = car_fixture(%{brand: "BMW"})
      assert Vehicle.list_cars([brand: "BMW"]) == [car]
    end

    test "create_car/1 with valid data creates a car" do
      %Brand{id: brand_id} = brand_fixture(%{name: "AvtoVAZ"})

      assert {:ok, %Car{} = car} = Vehicle.create_car(Enum.into(%{brand_id: brand_id}, @valid_attrs))
      assert car.body_type == :sedan
      assert car.brand_id == brand_id
      assert car.is_electric == false
      assert car.model == "test model"
      assert car.year == 1990
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicle.create_car(@invalid_attrs)
    end
  end
end
