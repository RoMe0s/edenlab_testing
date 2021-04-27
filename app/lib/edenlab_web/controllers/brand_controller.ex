defmodule EdenlabWeb.BrandController do
  use EdenlabWeb, :controller

  alias Edenlab.Vehicle

  action_fallback EdenlabWeb.FallbackController

  def index(conn, _params) do
    brands = Vehicle.list_brands()
    render(conn, "index.json", brands: brands)
  end
end
