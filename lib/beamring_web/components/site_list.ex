defmodule BeamringWeb.SiteList do
  use Phoenix.Component

  import BeamringWeb.CoreComponents

  attr :sites, :list, doc: "The list of sites to render"
  def render(assigns) do
    ~H"""
    <section>
      <.list>
        <:item :for={site <- @sites} title={site.title}>
          <.link
            href={site.url}
            class="text-brand hover:text-violet-700 hover:underline dark:text-violet-300 dark:hover:text-violet-500"
          >
            <%= site.url %>
          </.link>

          <p class="font-light text-zinc dark:text-gray-400"><%= site.description %></p>
        </:item>
      </.list>
    </section>
    """
  end
end
