defmodule OlxStore.Crawler.Store do
  @moduledoc """
  This module is a Crawler that will provide the comunication between the
  app and the store given. It will enable the app to fetch the store's
  html to parse further.
  """

  use HTTPoison.Base

  @endpoint "http://www.olx.com.br/loja/id/"

  def process_url(url) do
    @endpoint <> url
  end

  def process_response_body(body) do
    body |> Codepagex.to_string!(:iso_8859_1, Codepagex.use_utf_replacement())
  end
end
