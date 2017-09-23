defmodule OlxStore.Scraper.StoreListTest do
  use ExUnit.Case

  describe "get\1" do
    setup do
      {:ok, current_node} = Path.expand("./fixture/store.html") |> File.read
      store_list = OlxStore.Scraper.StoreList.get(current_node)

      {:ok, store_list: store_list}
    end

    @expected_result [
      %{
        image_url: "http://img.olx.com.br/thumbsli/21/218712086082483.jpg",
        link: "http://rj.olx.com.br/rio-de-janeiro-e-regiao/roupas-e-calcados/camisa-uzumaki-naruto-anime-388918412",
        title: "Camisa Uzumaki Naruto, anime",
        region: "Sao Goncalo - RJ",
        price: "R$ 35",
        publish_date: "12 Set",
        publish_time: "09:23"
      },
      %{
        image_url: "http://img.olx.com.br/thumbsli/20/205711084273930.jpg",
        link: "http://rj.olx.com.br/rio-de-janeiro-e-regiao/roupas-e-calcados/camiseta-naruto-uzumaki-388479039",
        title: "Camiseta Naruto Uzumaki",
        region: "Sao Goncalo - RJ",
        price: "",
        publish_date: "11 Set",
        publish_time: "11:03"
      },
      %{
        image_url: "http://img.olx.com.br/thumbsli/18/184709086287683.jpg",
        link: "http://rj.olx.com.br/rio-de-janeiro-e-regiao/roupas-e-calcados/baby-look-sons-of-anarchy-387820418",
        title: "Baby look Sons of Anarchy",
        region: "Sao Goncalo - RJ",
        price: "",
        publish_date: "9 Set",
        publish_time: "11:28"
      },
      %{
        image_url: "http://img.olx.com.br/thumbsli/18/182708088762432.jpg",
        link: "http://rj.olx.com.br/rio-de-janeiro-e-regiao/roupas-e-calcados/camisa-camiseta-goku-super-sayajin-1-2-3-dragon-ball-z-gt-k-387688406",
        title: "Camisa, Camiseta Goku Super Sayajin 1 2 3 Dragon Ball Z Gt K",
        region: "Sao Goncalo - RJ",
        price: "",
        publish_date: "8 Set",
        publish_time: "23:00"
      },
      %{
        image_url: "http://img.olx.com.br/thumbsli/18/188708084109420.jpg",
        link: "http://rj.olx.com.br/rio-de-janeiro-e-regiao/roupas-e-calcados/camiseta-naruto-anime-387678054",
        title: "Camiseta Naruto anime",
        region: "Sao Goncalo - RJ",
        price: "",
        publish_date: "8 Set",
        publish_time: "22:16"
      },
      %{
        image_url: "http://img.olx.com.br/thumbsli/17/175707088810266.jpg",
        link: "http://rj.olx.com.br/rio-de-janeiro-e-regiao/roupas-e-calcados/camisa-game-of-thrones-house-stark-387291389?last=1",
        title: "Camisa, Game of Thrones , House Stark",
        region: "Sao Goncalo - RJ",
        price: "",
        publish_date: "7 Set",
        publish_time: "22:49"
      }
    ]

    test "returns a list with all items", %{store_list: store_list} do
      assert Enum.count(store_list) == 6
    end

    test "each item should contains a link", %{store_list: store_list} do
      assert_each(store_list, :image_url, @expected_result)
    end

    test "each item should contains an image_url", %{store_list: store_list} do
      assert_each(store_list, :image_url, @expected_result)
    end

    test "each item should contains a title", %{store_list: store_list} do
      assert_each(store_list, :title, @expected_result)
    end

    test "each item should contains a region", %{store_list: store_list} do
      assert_each(store_list, :region, @expected_result)
    end

    test "each item should contains a price", %{store_list: store_list} do
      assert_each(store_list, :price, @expected_result)
    end

    test "each item should contains a publishing_date", %{store_list: store_list} do
      assert_each(store_list, :publish_date, @expected_result)
    end

    test "each item should contains a publishing_time", %{store_list: store_list} do
      assert_each(store_list, :publish_time, @expected_result)
    end
  end

  def assert_each(list, key, expected_list) when
    is_list(list) and
    is_atom(key) and
    is_list(expected_list) do

    list |> Enum.with_index |> Enum.each(fn({item, index}) ->
      expected_result = expected_list |> Enum.at(index) |> Map.fetch!(key)
      assert Map.fetch!(item, key) == expected_result
    end)
  end
end
