defmodule Beamring.Ring do
  @moduledoc """
  Core utilities for the WebRing
  """

  @sites [
    "https://silbernagel.dev",
    "https://readreplica.io"
  ]

  @doc """
  Returns all sites in the ring
  """
  @spec all :: [String.t()]
  def all(), do: @sites

  @doc """
  Get the previous site
  """
  @spec previous(String.t()) :: String.t()
  def previous(host) do
    host
    |> find_with_index()
    |> case do
      nil -> ""
      {_v, i} -> Enum.at(@sites, i - 1)
    end
  end

  @doc """
  Get the next site
  """
  @spec next(String.t()) :: String.t()
  def next(host) do
    size = length(@sites)

    host
    |> find_with_index()
    |> case do
      nil ->
        ""

      {_v, i} ->
        if size == i + 1,
          do: Enum.at(@sites, 0),
          else: Enum.at(@sites, i + 1)
    end
  end

  defp find_with_index(host) do
    @sites
    |> Enum.with_index()
    |> Enum.find(fn {v, _i} -> v == host end)
  end
end
