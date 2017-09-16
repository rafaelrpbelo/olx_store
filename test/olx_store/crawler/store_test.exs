defmodule OlxStore.Crawler.StoreTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get\1" do
    test "sends requests against http://www.olx.com.br/loja/id" do
      use_cassette :stub, [url: "http://www.olx.com.br/loja/id/1", method: "get", body: "success"] do
        {:ok, response} = OlxStore.Crawler.Store.get(1)
        assert response.body == "success"
      end
    end

    test "converts body response from binary to iso_8859_1" do
      response_params = [
        url: "http://www.olx.com.br/loja/id/1",
        method: "get",
        body: <<83, 227, 111, 32, 66, 101, 114, 110, 97, 114, 100, 111,
        32, 100, 111, 32, 67, 97, 109, 112, 111>>
      ]

      use_cassette :stub, response_params do
        {:ok, response} = OlxStore.Crawler.Store.get(1)
        assert response.body == "São Bernardo do Campo"
      end
    end
  end
end
