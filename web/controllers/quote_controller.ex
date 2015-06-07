defmodule Splurty.QuoteController do
  use Splurty.Web, :controller

  alias Splurty.Router
  import Splurty.Router.Helpers

  plug :action
  plug :render when action in [:index]

  def homepage(conn, _params) do
    conn
    |> render "show.html", quote: Splurty.Quote.Queries.random
  end

  def index(conn, _params) do
    conn
    |> assign(:quotes, Splurty.Repo.all(Splurty.Quote))
  end

  def new(conn, _params) do
    render conn, "new.html", quote: Ecto.Changeset.change(%Splurty.Quote{})
  end

  def create(conn, %{"quote" => %{"saying" => saying, "author" => author}}) do
    Splurty.Repo.insert(%Splurty.Quote{saying: saying, author: author})

    redirect conn, to: quote_path(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", quote: Splurty.Repo.get(Splurty.Quote, id)
  end

  def edit(conn, %{"id" => id}) do
    quote = Ecto.Changeset.change(Splurty.Repo.get(Splurty.Quote, id))
    render conn, "edit.html", quote: quote
  end

  def update(conn, %{"id" => id, "quote" => %{"saying" => saying, "author" => author}}) do
    quote = %{Splurty.Repo.get(Splurty.Quote, id) | saying: saying, author: author}
    Splurty.Repo.update(quote)

    redirect conn, to: quote_path(conn, :show, quote.id)
  end

  def delete(conn, %{"id" => id}) do
    Splurty.Repo.delete(Splurty.Repo.get(Splurty.Quote, id))

    redirect conn, to: quote_path(conn, :index)
  end
end
