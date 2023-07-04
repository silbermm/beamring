defmodule BeamringWeb.RingController do
  use BeamringWeb, :controller

  alias Beamring.Ring
  require Logger

  def previous(conn, %{"host" => host}) do
    case Ring.previous(host) do
      "" ->
        Logger.error("invalid host")
        redirect(conn, to: ~p"/?host=invalid_host")

      previous ->
        redirect(conn, external: previous)
    end
  end



  def next(conn, %{"host" => host}) do
    case Ring.next(host) do
      "" ->
        Logger.error("invalid host")
        redirect(conn, to: ~p"/?host=invalid_host")

      next ->
        redirect(conn, external: next)
    end
  end

  def next(conn, _params) do
    Logger.error("invalid params")
    redirect(conn, to: ~p"/?host=invalid_params")
  end
end
