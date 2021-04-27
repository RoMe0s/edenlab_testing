defmodule EdenlabWeb.CarControllerTest do
  use EdenlabWeb.ConnCase

  alias Edenlab.Repo
  alias Edenlab.Vehicle
  alias Edenlab.Vehicle.Brand

  @brand_attrs %{name: "BMW"}

  @create_attrs %{
    body_type: :sedan,
    is_electric: false,
    model: "test model",
    year: 1990
  }
  @invalid_attrs %{body_type: "random_string", brand_id: 0, id: nil, is_electric: nil, model: nil, year: nil}

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
      |> Enum.into(@create_attrs)
      |> Vehicle.create_car()
    car
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "empty list when no cars", %{conn: conn} do
      conn = get(conn, Routes.car_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists of all cars", %{conn: conn} do
      car_fixture()

      conn = get(conn, Routes.car_path(conn, :index))
      assert json_response(conn, 200)["data"] == [
        %{
          "brand" => "BMW",
          "body_type" => "sedan",
          "is_electric" => false,
          "model" => "test model",
          "year" => 1990
        }
      ]
    end
  end

  describe "create car" do
    test "renders car when data is valid", %{conn: conn} do
      %Brand{id: brand_id} = brand_fixture()
      conn = post(conn, Routes.car_path(conn, :create), Enum.into(%{brand_id: brand_id}, @create_attrs))

      assert %{
               "body_type" => "sedan",
               "brand" => "BMW",
               "is_electric" => false,
               "model" => "test model",
               "year" => 1990
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), @invalid_attrs)
      assert json_response(conn, 422)["error"] == %{"invalid" => [
        %{"entry" => "model", "entry_type" => "string", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]},
        %{"entry" => "year", "entry_type" => "integer", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]},
        %{"entry" => "is_electric", "entry_type" => "boolean", "rules" => [%{"description" => "can't be blank", "validation" => "required"}]},
        %{"entry" => "brand_id", "entry_type" => "uuid", "rules" => [%{"description" => "is invalid", "validation" => "exists"}]},
        %{"entry" => "body_type", "entry_type" => "enum", "rules" => [%{"description" => "is invalid", "validation" => "subset", "values" => ["sedan", "coupe", "pickup"]}]}
      ]}
    end
  end
end
