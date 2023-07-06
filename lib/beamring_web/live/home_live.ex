defmodule BeamringWeb.HomeLive do
  use BeamringWeb, :live_view

  alias Beamring.Ring

  @impl true
  def mount(_, _, socket) do
    sites = Ring.all()
    {:ok, assign(socket, sites: sites)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h2>Welcome to Beamring</h2>
    <section>
      <p>A Webring for all things BEAM related including</p>
    </section>

    <h2 id="getting-started">Getting Started</h2>
    <section>
      <h3>Step 1</h3>
      <p>Add this snippet somewhere on your site, typically the footer</p>
      <code>
        <pre> &lt;hello&gt;  &lt;/hello&gt;</pre>
      </code>
    </section>

    <h2 id="members">Sites</h2>
    <section>
      <ul>
        <li :for={site <- @sites}><.link href={site}> <%= site %> </.link></li>
      </ul>
    </section>
    """
  end
end
