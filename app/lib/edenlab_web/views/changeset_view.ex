defmodule EdenlabWeb.ChangesetView do
  use EdenlabWeb, :view

  alias Edenlab.Vehicle.Car

  @doc """
  Traverses and translates changeset errors.

  See `EdenlabWeb.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(%Ecto.Changeset{errors: errors}) do
    entry_type = fn
      Ecto.UUID -> "uuid"
      {_, Ecto.Enum, _} -> "enum"
      type -> type
    end

    build_rule = fn error ->
      case error do
        {_, [type: {_, Ecto.Enum, %{values: values}}, validation: :cast]} -> %{
          description: translate_error(error),
          values: values,
          validation: "subset"
        }
        {_, [type: Ecto.UUID, validation: _]} -> %{
          description: translate_error(error),
          validation: "exists"
        }
        {_, [validation: :inclusion, enum: from..to]} -> %{
          description: translate_error(error),
          values: %{from: from, to: to},
          validation: "inclusion"
        }
        {_, [validation: validation]} -> %{
          description: translate_error(error),
          validation: validation
        }
        _ -> %{
          description: translate_error(error),
        }
      end
    end

    Enum.map(errors, fn {key, error} ->
      entry_type = entry_type.(Car.__schema__(:type, key))

      %{
        entry: key,
        entry_type: entry_type,
        rules: [
          build_rule.(error)
        ]
      }
    end)
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{error: %{
      invalid: translate_errors(changeset)
    }}
  end
end
