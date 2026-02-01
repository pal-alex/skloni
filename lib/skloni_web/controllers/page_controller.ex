defmodule SkloniWeb.PageController do
  use SkloniWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
