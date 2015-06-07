defmodule Splurty.Quote do
  use Splurty.Web, :model

  schema "quotes" do
    field :saying, :string
    field :author, :string
  end

  defmodule Queries do
    import Ecto.Query

    def random do
      query = from q in Splurty.Quote,
                limit: 1,
                select: [q.saying, q.author],
                order_by: fragment("random()")

      [saying, author] = Splurty.Repo.all(query) |> List.first
      %Splurty.Quote{saying: saying, author: author}
    end
  end
end
