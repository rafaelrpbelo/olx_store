defmodule OlxStore.Crawler.Store do
  use HTTPoison.Base

  @endpoint "http://www.olx.com.br/loja/id/"

  def process_url(url) do
    @endpoint <> url
  end

  def process_response_body(body) do
    body |> Codepagex.to_string!(:iso_8859_1, Codepagex.use_utf_replacement())
  end
end
