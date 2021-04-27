# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Edenlab.Repo.insert!(%Edenlab.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Edenlab.Repo.insert!(%Edenlab.Vehicle.Brand{name: "BMW"})
Edenlab.Repo.insert!(%Edenlab.Vehicle.Brand{name: "Ferrari"})
Edenlab.Repo.insert!(%Edenlab.Vehicle.Brand{name: "Tesla"})
Edenlab.Repo.insert!(%Edenlab.Vehicle.Brand{name: "AvtoVAZ"})
