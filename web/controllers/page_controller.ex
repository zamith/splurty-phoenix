defmodule Splurty.PageController do
  use Splurty.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
