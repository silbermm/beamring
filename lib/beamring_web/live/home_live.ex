defmodule BeamringWeb.HomeLive do
  use BeamringWeb, :live_view

  @impl true
  def handle_params(params, _session, socket) do
    IO.inspect params
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1> BeamRing </h1>
    """
  end
end
