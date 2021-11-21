defmodule <%= inspect schema.repo %>.Migrations.Create<%= Macro.camelize(schema.table) %>Tables do
  use Ecto.Migration

  def change do
    create table(:countries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :continent, :string
      add :iso, :string
      add :iso3, :string
      add :prefered_language, :string
      add :locales, {:array, :string}
      add :tld, :string
      add :currency, :string
      add :area, :integer
      add :population, :integer

      timestamps()
    end

    create unique_index(:countries, [:iso])
    
    create table(:cities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :size, :string
      add :avg_rent, :integer
      add :region_id, references(:regions, on_delete: :nothing, type: :binary_id)
      add :country_id, references(:countries, on_delete: :nothing, type: :binary_id)
      add :climate_type_id, references(:climate_types, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:cities, [:region_id])
    create index(:cities, [:country_id])
    create index(:cities, [:climate_type_id])
  end
end
