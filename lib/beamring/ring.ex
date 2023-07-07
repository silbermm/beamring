defmodule Beamring.Ring do
  @moduledoc """
  Core utilities for the WebRing
  """

  @sites [
    %{
      title: "Matt Silbernagel",
      url: "https://silbernagel.dev",
      description: "Blog and Notes about Elixir"
    },
    %{
      title: "ReadReplica",
      url: "https://readreplica.io",
      description: "Software Engineering and System Design newsletter"
    }
  ]

  @doc """
  Returns all sites in the ring
  """
  @spec all :: [map()]
  def all(), do: @sites

  @doc """
  Get the previous site
  """
  @spec previous(String.t()) :: map()
  def previous(host) do
    host
    |> find_with_index()
    |> case do
      nil -> nil
      {_v, i} -> Enum.at(@sites, i - 1)
    end
  end

  @doc """
  Get the next site
  """
  @spec next(String.t()) :: map()
  def next(host) do
    size = length(@sites)

    host
    |> find_with_index()
    |> case do
      nil ->
        nil

      {_v, i} ->
        if size == i + 1,
          do: Enum.at(@sites, 0),
          else: Enum.at(@sites, i + 1)
    end
  end

  defp find_with_index(host) do
    @sites
    |> Enum.with_index()
    |> Enum.find(fn {mp, _i} -> mp.url == host end)
  end
end
