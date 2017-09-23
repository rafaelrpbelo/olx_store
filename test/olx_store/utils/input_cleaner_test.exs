defmodule OlxStore.Utils.InputCleanerTest do
  use ExUnit.Case

  describe "clean\1" do
    test "trims the input" do
      sample = "      My sample string   "
      assert OlxStore.Utils.InputCleaner.clean(sample) == "My sample string"
    end

    test "removes multiple whitespaces between words" do
      sample = "My  sample       string"
      assert OlxStore.Utils.InputCleaner.clean(sample) == "My sample string"
    end

    test "removes tabs, new line and carrier returns" do
      sample = "\n\n\r\tMy  \t\nsample \n\n\t\r      string\t\n\n\r"
      assert OlxStore.Utils.InputCleaner.clean(sample) == "My sample string"
    end
  end
end
