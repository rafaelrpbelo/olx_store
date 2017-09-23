defmodule OlxStore.Scraper.StoreInfo do
  @moduledoc """
  This module find informations about a store from a given html text node

  The informations that will be looked up, are:
  - Store name
  - Description
  - Region
  - Address
  - Zipcode
  - Thumbail image url
  """

  @spec get(String.t) :: %{}
  def get(current_node) do
    info_node = current_node |> Floki.find("div.store-info")

    get_name(info_node)
    |> get_region(info_node)
    |> get_addresses(info_node)
    |> get_thumb_image_url(current_node)
    |> get_description(current_node)
  end

  defp get_name(info \\ %{}, current_node) do
    name = current_node
      |> Floki.find(".store-title")
      |> Floki.text

    info |> Map.merge(%{name: name})
  end

  defp get_region(info, current_node) do
    region = current_node
      |> Floki.find(".store-region")
      |> Floki.text

    info |> Map.merge(%{region: region})
  end

  defp get_addresses(info, current_node) do
    address = current_node
      |> Floki.find(".store-adress")

    get_address(info, address)
  end

  defp get_address(info, [address, zip]) do
    address = address |> Floki.text
    zip = zip |> Floki.text

    info |> Map.merge(%{address: address, zip: zip})
  end

  defp get_address(info, [address]) do
    address = address |> Floki.text

    info |> Map.merge(%{address: address})
  end

  defp get_address(info, []), do: info

  defp get_description(info, current_node) do
    description = current_node
      |> Floki.find(".store-description")
      |> Floki.text

    info |> Map.merge(%{description: description})
  end

  defp get_thumb_image_url(info, current_node) do
    thumb_image_url = current_node
      |> Floki.find(".store-info-image")
      |> Floki.find("img")
      |> Floki.attribute("src")
      |> List.first

    info |> Map.merge(%{thumb_image_url: thumb_image_url})
  end
end
