defmodule OlxStore.Utils.InputCleaner do
  @moduledoc """
  This module will clean a given input to normalize data
  """

  @doc """

  Returns a cleaned string

  ## Parameters:

    - input: String that represent a input that need to be cleaned

  ## Examples

    iex> OlxStore.Utils.InputCleaner.clean("      My sample string   ")
    "My sample string"

    iex> OlxStore.Utils.InputCleaner.clean("\n\t\t\t\t\tMy sample string\n\t\t\t\t\t")
    "My sample string"

    iex> OlxStore.Utils.InputCleaner.clean("  \n\t \t\t\t\tMy \t \n\nsample  \n\n\t string\n\t\t\t")
    "My sample string"

  """
  @spec clean(String.t) :: String.t
  def clean(input) do
    input
    |> String.trim
    |> String.replace(~r/[\r\t\n]/, "")
    |> String.replace(~r/(\s{2,})/, " ")
  end
end
