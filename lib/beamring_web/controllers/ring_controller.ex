defmodule BeamringWeb.RingController do
  use BeamringWeb, :controller

  alias Beamring.Ring
  alias BeamringWeb.ErrorHTML
  require Logger

  def previous(conn, %{"host" => host}) do
    case Ring.previous(host) do
      "" ->
        Logger.error("invalid host: #{host}")

        conn
        |> put_view(ErrorHTML)
        |> put_status(404)
        |> render("404_host.html", %{host: host, action: :previous})

      previous ->
        redirect(conn, external: previous)
    end
  end

  def previous(conn, params) do
    Logger.error("invalid params: #{inspect(params)}")

    conn
    |> put_view(ErrorHTML)
    |> put_status(400)
    |> render("400.html", %{action: :previous})
  end

  def next(conn, %{"host" => host}) do
    case Ring.next(host) do
      "" ->
        Logger.error("invalid host: #{host}")

        conn
        |> put_view(ErrorHTML)
        |> put_status(404)
        |> render("404_host.html", %{host: host, action: :next})

      next ->
        redirect(conn, external: next)
    end
  end

  def next(conn, params) do
    Logger.error("invalid params: #{inspect(params)}")

    conn
    |> put_view(ErrorHTML)
    |> put_status(400)
    |> render("400.html", %{action: :next})
  end
end
