defmodule Mix.Tasks.Phx.Gen.Geonames do
  @moduledoc """

  Generate Geonames schems and data syncronization 

  mix phx.gen.geonames

  """
  use Mix.Task
  @city ~w(Geonames.City cities name:string )

  def run(_args) do
    context =
      %{
        web_app_name: Mix.Phoenix.otp_app(),
        in_umbrella?: Mix.Phoenix.in_umbrella?(File.cwd!())
      }
      |> IO.inspect()

    # {context, schema} = Mix.Tasks.Phx.Gen.Context.build([], __MODULE__) |> IO.inspect()

    # paths = generator_paths()

    # binding = [schema: %{repo: "MyRepo", table: "Geonames"}]

    # Mix.Phoenix.copy_from(paths, "priv/templates/phx.gen.geonames", binding, files())
    Mix.Tasks.Phx.Gen.Schema.run()
    # create sync mix task
  end

  defp files() do
    # migrations_prefix = Mix.Phoenix.context_app_path(context_app, "priv/repo/migrations")
    migrations_prefix = "priv/repo/migrations"

    [
      {:eex, "migration.ex",
       Path.join([migrations_prefix, "#{timestamp()}_create_geonames_tables.exs"])}
    ]
  end

  defp generator_paths do
    [".", :phx_gen_geonames, :phoenix]
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: <<?0, ?0 + i>>
  defp pad(i), do: to_string(i)
end
