defmodule Edenlab.Vehicle do
  import Ecto.Query, only: [from: 2]

  alias Edenlab.Repo

  alias Edenlab.Vehicle.Brand
  alias Edenlab.Vehicle.Car

  @doc """
  Returns the list of brands.

  ## Examples

      iex> list_brands()
      [%Brand{}, ...]

  """
  def list_brands do
    Repo.all(Brand)
  end

  @doc """
  Returns the list of cars.

  ## Examples

      iex> list_cars()
      [%Car{}, ...]

  """
  def list_cars([]) do
    Repo.all(Car)
  end

  def list_cars(filters) when is_list(filters) do
    prepared_filters =
      if Keyword.has_key?(filters, :brand) do
        filters =
          case Repo.get_by(Brand, name: Keyword.fetch!(filters, :brand)) do
            %Brand{id: brand_id} -> Keyword.put(filters, :brand_id, brand_id)
            _ -> filters
          end

        Keyword.delete(filters, :brand)
      else
        filters
      end

    Repo.all(from Car, where: ^prepared_filters)
  end

  @doc """
  Creates a car.

  ## Examples

      iex> create_car(%{field: value})
      {:ok, %Car{}}

      iex> create_car(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_car(attrs \\ %{}) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end
end
