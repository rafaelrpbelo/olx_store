defmodule OlxStore.Scraper.StoreList do
  @moduledoc """
  This module will provide a list of items found at store given
  """

  alias OlxStore.Utils.InputCleaner

  @spec get(String.t) :: [
    %{
      image_url: String.t,
      link: String.t,
      title: String.t,
      region: String.t,
      price: String.t,
      publish_date: String.t,
      publish_time: String.t
    }
  ]
  def get(current_node) do
    current_node
    |> Floki.find(".section_OLXad-list ")
    |> Floki.find("li[class='item']")
    |> Enum.map(&(get_all(&1)))
  end

  defp get_all(item \\ %{}, item_node) do
    item
    |> get_link(item_node)
    |> get_image_url(item_node)
    |> get_title(item_node)
    |> get_region(item_node)
    |> get_price(item_node)
    |> get_publish_date_and_time(item_node)
  end

  defp get_link(item, current_node) do
    link = current_node
      |> Floki.find("a")
      |> Floki.attribute("href")
      |> List.first

    Map.merge(item, %{link: link})
  end

  defp get_image_url(item, current_node) do
    [{_tag, attributes, _content}] = current_node
      |> Floki.find(".OLXad-list-image-box img")

    image_url = attributes
      |> Enum.filter(fn({attribute, _val}) -> attribute == "data-original" || attribute == "src" end)
      |> take_prior_image

    Map.merge(item, %{image_url: image_url})
  end
  defp take_prior_image([{"src", _src}, {"data-original", data_original}]), do: data_original
  defp take_prior_image([{"src", src}]), do: src
  defp take_prior_image([]), do: ""

  defp get_title(item, current_node) do
    title = current_node
      |> Floki.find(".OLXad-list-title")
      |> get_text

    Map.merge(item, %{title: title})
  end

  defp get_region(item, current_node) do
    region = current_node
      |> Floki.find(".detail-region")
      |> get_text

    Map.merge(item, %{region: region})
  end

  defp get_price(item, current_node) do
    price = current_node
      |> Floki.find(".OLXad-list-price")
      |> get_text

    Map.merge(item, %{price: price})
  end

  defp get_publish_date_and_time(item, current_node) do
    [publish_date, publish_time] = current_node
      |> Floki.find(".col-4 p")
      |> Enum.map(&(get_text(&1)))

    Map.merge(item, %{publish_date: publish_date})
    |> Map.merge(%{publish_time: publish_time})
  end

  defp get_text(input) do
    input |> Floki.text |> InputCleaner.clean
  end
end
