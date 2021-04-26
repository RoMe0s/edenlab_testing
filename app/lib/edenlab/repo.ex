defmodule Edenlab.Repo do
  use Ecto.Repo,
    otp_app: :edenlab,
    adapter: Ecto.Adapters.Postgres
end
