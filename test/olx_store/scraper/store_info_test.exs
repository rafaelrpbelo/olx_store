defmodule OlxStore.Scraper.StoreInfoTest do
  use ExUnit.Case

  describe "get\1" do
    test "returns a map with name, region, address, zip and thumb_image_url" do
      current_node = Path.expand("./fixture/store.html")
        |> File.read!
        |> Floki.parse

      expected_result = %{
        name: "NERDS COMICS",
        region: "Sao Goncalo - RJ",
        address: "R. Milton Nunes - Santa Luzia",
        zip: "CEP 24722-175",
        thumb_image_url: "http://img.olx.com.br/storeli/20/201711084703688.jpg",
        description: "A Nerds Comics foi fundada com objetivo de atender o publico geek / nerd, com o intuito de proporcionar uma experiência única neste universo."
      }

      assert OlxStore.Scraper.StoreInfo.get(current_node) == expected_result
    end
  end
end
