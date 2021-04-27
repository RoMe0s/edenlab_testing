defmodule EdenlabWeb.CarView do
  use EdenlabWeb, :view
  alias EdenlabWeb.CarView

  def render("index.json", %{cars: cars}) do
    cars = Edenlab.Repo.preload(cars, :brand)

    %{data: render_many(cars, CarView, "car.json")}
  end

  def render("show.json", %{car: car}) do
    car = Edenlab.Repo.preload(car, :brand)

    %{data: render_one(car, CarView, "car.json")}
  end

  def render("car.json", %{car: car}) do
    %{
      brand: car.brand.name,
      model: car.model,
      year: car.year,
      body_type: car.body_type,
      is_electric: car.is_electric
    }
  end
end
