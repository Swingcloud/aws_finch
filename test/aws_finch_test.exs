defmodule AwsFinchTest do
  use ExUnit.Case
  doctest AwsFinch

  test "greets the world" do
    assert AwsFinch.hello() == :world
  end
end
