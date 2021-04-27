defmodule EdenlabWeb.CarController do
  use EdenlabWeb, :controller

  alias Edenlab.Vehicle
  alias Edenlab.Vehicle.Car

  action_fallback EdenlabWeb.FallbackController

  def index(conn, params) do
    filters = params
    |> Map.take(["brand", "body_type", "is_electric"])
    |> Map.to_list()
    |> Enum.map(fn {key, value} -> {String.to_existing_atom(key), value} end)

    cars = Vehicle.list_cars(filters)
    render(conn, "index.json", cars: cars)
  end

  def create(conn, %{} = params) do
    with {:ok, %Car{} = car} <- Vehicle.create_car(params) do
      render(conn, "show.json", car: car)
    end
  end
end
