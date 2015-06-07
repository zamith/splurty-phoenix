defmodule Splurty.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :saying, :string, size: 140
      add :author, :string, size: 140
    end
  end
end
