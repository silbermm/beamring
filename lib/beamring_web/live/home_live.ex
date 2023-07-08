defmodule BeamringWeb.HomeLive do
  use BeamringWeb, :live_view

  alias Beamring.Ring
  alias BeamringWeb.SiteList

  @impl true
  def mount(_, _, socket) do
    socket =
      socket
      |> assign_new(:sites, fn -> Ring.all() end)
      |> assign_new(:page_title, fn -> "Home" end)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="py-8">
      <.header>
        Welcome to Beamring
        <:subtitle>
          A
          <.link
            href="https://en.wikipedia.org/wiki/Webring"
            class="text-brand hover:text-violet-700 hover:underline dark:text-violet-300 dark:hover:text-violet-500"
          >
            Webring
          </.link>
          for all things BEAM related including <b> Elixir </b>, <b> Erlang </b>
          and <b> Gleam </b>
        </:subtitle>
      </.header>
    </div>

    <div class="py-8">
      <.header class="border-b border-zinc-500">
        Current Sites
      </.header>
      <SiteList.render sites={@sites} />
    </div>

    <div class="py-8">
      <.header id="getting-started" class="border-b border-zinc-500">Join the Webring</.header>

      <h3 class="text-md font-semibold py-2 dark:text-gray-300">Step 1</h3>
      <p class="pt-2 dark:text-gray-400">
        Add this snippet (or something similar) somewhere on your site, typically the footer, that is available on all pages.
      </p>
      <p class="py-2 dark:text-gray-400">
        Make sure to replace `https://yoursite.dev` with <b> your URL </b>
      </p>
      <div class="border rounded py-4 overflow-auto text-xs dark:text-white dark:bg-gray-700">
        <code>
          <pre>
     &lt;div&gt;
      &lt;p&gt;
        &lt;a href="https://beamring.io/previous?host=https://yoursite.dev"&gt;←&lt;/a&gt;
        &lt;a href="https://beamring.io"&gt;Beamring&lt;/a&gt;
        &lt;a href="https://beamring.io/next?host=https://yoursite.dev"&gt;→&lt;/a&gt;
      &lt;/p&gt;
     &lt;/div&gt;
          </pre>
        </code>
      </div>

      <h3 class="text-md font-semibold py-2 dark:text-gray-300 mt-2">Step 2</h3>
      <p class="pt-2 dark:text-gray-400">
        <.link
          class="text-brand hover:text-violet-700 hover:underline dark:text-violet-300 dark:hover:text-violet-500"
          href="https://github.com/silbermm/beamring/issues/new?assignees=silbermm&labels=new&projects=&template=add_site.yml&title=%5BAdd%5D%3A+"
          target="_blank"
        >
          Fill out this form
        </.link>
        with information about your site.
      </p>
    </div>
    """
  end
end
