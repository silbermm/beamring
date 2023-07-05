defmodule BeamringWeb.RingController do
  use BeamringWeb, :controller

  alias Beamring.Ring
  alias BeamringWeb.ErrorHTML
  require Logger

  def previous(conn, %{"host" => host}) do
    case Ring.previous(host) do
      "" ->
        Logger.error("invalid host: #{host}")
        redirect(conn, to: ~p"/?error=invalid_host&action=previous")

      previous ->
        redirect(conn, external: previous)
    end
  end

  def previous(conn, params) do
    Logger.error("invalid params: #{inspect params}")
    redirect(conn, to: ~p"/?error=invalid_params&action=previous")
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
    Logger.error("invalid params: #{inspect params}")
    redirect(conn, to: ~p"/?error=invalid_params&action=next")
  end
end
