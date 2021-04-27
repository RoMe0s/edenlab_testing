defmodule Edenlab.VehicleTest do
  use Edenlab.DataCase

  alias Edenlab.Vehicle

  describe "brands" do
    alias Edenlab.Vehicle.Brand

    @valid_attrs %{id: "7488a646-e31f-11e4-aace-600308960662", name: "some name"}
    @update_attrs %{id: "7488a646-e31f-11e4-aace-600308960668", name: "some updated name"}
    @invalid_attrs %{id: nil, name: nil}

    def brand_fixture(attrs \\ %{}) do
      {:ok, brand} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vehicle.create_brand()

      brand
    end

    test "list_brands/0 returns all brands" do
      brand = brand_fixture()
      assert Vehicle.list_brands() == [brand]
    end

    test "get_brand!/1 returns the brand with given id" do
      brand = brand_fixture()
      assert Vehicle.get_brand!(brand.id) == brand
    end

    test "create_brand/1 with valid data creates a brand" do
      assert {:ok, %Brand{} = brand} = Vehicle.create_brand(@valid_attrs)
      assert brand.id == "7488a646-e31f-11e4-aace-600308960662"
      assert brand.name == "some name"
    end

    test "create_brand/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicle.create_brand(@invalid_attrs)
    end

    test "update_brand/2 with valid data updates the brand" do
      brand = brand_fixture()
      assert {:ok, %Brand{} = brand} = Vehicle.update_brand(brand, @update_attrs)
      assert brand.id == "7488a646-e31f-11e4-aace-600308960668"
      assert brand.name == "some updated name"
    end

    test "update_brand/2 with invalid data returns error changeset" do
      brand = brand_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicle.update_brand(brand, @invalid_attrs)
      assert brand == Vehicle.get_brand!(brand.id)
    end

    test "delete_brand/1 deletes the brand" do
      brand = brand_fixture()
      assert {:ok, %Brand{}} = Vehicle.delete_brand(brand)
      assert_raise Ecto.NoResultsError, fn -> Vehicle.get_brand!(brand.id) end
    end

    test "change_brand/1 returns a brand changeset" do
      brand = brand_fixture()
      assert %Ecto.Changeset{} = Vehicle.change_brand(brand)
    end
  end

  describe "cars" do
    alias Edenlab.Vehicle.Car

    @valid_attrs %{body_type: "some body_type", brand_id: "7488a646-e31f-11e4-aace-600308960662", id: "7488a646-e31f-11e4-aace-600308960662", is_electric: true, model: "some model", year: 42}
    @update_attrs %{body_type: "some updated body_type", brand_id: "7488a646-e31f-11e4-aace-600308960668", id: "7488a646-e31f-11e4-aace-600308960668", is_electric: false, model: "some updated model", year: 43}
    @invalid_attrs %{body_type: nil, brand_id: nil, id: nil, is_electric: nil, model: nil, year: nil}

    def car_fixture(attrs \\ %{}) do
      {:ok, car} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vehicle.create_car()

      car
    end

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Vehicle.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Vehicle.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      assert {:ok, %Car{} = car} = Vehicle.create_car(@valid_attrs)
      assert car.body_type == "some body_type"
      assert car.brand_id == "7488a646-e31f-11e4-aace-600308960662"
      assert car.id == "7488a646-e31f-11e4-aace-600308960662"
      assert car.is_electric == true
      assert car.model == "some model"
      assert car.year == 42
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicle.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      assert {:ok, %Car{} = car} = Vehicle.update_car(car, @update_attrs)
      assert car.body_type == "some updated body_type"
      assert car.brand_id == "7488a646-e31f-11e4-aace-600308960668"
      assert car.id == "7488a646-e31f-11e4-aace-600308960668"
      assert car.is_electric == false
      assert car.model == "some updated model"
      assert car.year == 43
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicle.update_car(car, @invalid_attrs)
      assert car == Vehicle.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Vehicle.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Vehicle.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Vehicle.change_car(car)
    end
  end
end
