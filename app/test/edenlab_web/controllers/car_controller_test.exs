defmodule EdenlabWeb.CarControllerTest do
  use EdenlabWeb.ConnCase

  alias Edenlab.Vehicle
  alias Edenlab.Vehicle.Car

  @create_attrs %{
    body_type: "some body_type",
    brand_id: "7488a646-e31f-11e4-aace-600308960662",
    id: "7488a646-e31f-11e4-aace-600308960662",
    is_electric: true,
    model: "some model",
    year: 42
  }
  @update_attrs %{
    body_type: "some updated body_type",
    brand_id: "7488a646-e31f-11e4-aace-600308960668",
    id: "7488a646-e31f-11e4-aace-600308960668",
    is_electric: false,
    model: "some updated model",
    year: 43
  }
  @invalid_attrs %{body_type: nil, brand_id: nil, id: nil, is_electric: nil, model: nil, year: nil}

  def fixture(:car) do
    {:ok, car} = Vehicle.create_car(@create_attrs)
    car
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cars", %{conn: conn} do
      conn = get(conn, Routes.car_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create car" do
    test "renders car when data is valid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), car: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.car_path(conn, :show, id))

      assert %{
               "id" => id,
               "body_type" => "some body_type",
               "brand_id" => "7488a646-e31f-11e4-aace-600308960662",
               "is_electric" => true,
               "model" => "some model",
               "year" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.car_path(conn, :create), car: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update car" do
    setup [:create_car]

    test "renders car when data is valid", %{conn: conn, car: %Car{id: id} = car} do
      conn = put(conn, Routes.car_path(conn, :update, car), car: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.car_path(conn, :show, id))

      assert %{
               "id" => id,
               "body_type" => "some updated body_type",
               "brand_id" => "7488a646-e31f-11e4-aace-600308960668",
               "is_electric" => false,
               "model" => "some updated model",
               "year" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, car: car} do
      conn = put(conn, Routes.car_path(conn, :update, car), car: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete car" do
    setup [:create_car]

    test "deletes chosen car", %{conn: conn, car: car} do
      conn = delete(conn, Routes.car_path(conn, :delete, car))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.car_path(conn, :show, car))
      end
    end
  end

  defp create_car(_) do
    car = fixture(:car)
    %{car: car}
  end
end
