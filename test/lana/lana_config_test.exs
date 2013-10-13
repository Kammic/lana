defmodule LanaConfigTest do
  use ExUnit.Case

  def fixture_path do
    "#{System.cwd}/test/fixtures/example.yml"
  end

  test "#load_file fails on unkown file" do
    {:error, _} = Lana.Config.load_file('unknown_file.yml')
  end

  test "#load_file works with correct file" do
    {status, _} = Lana.Config.load_file(fixture_path)
    refute status == :error
  end

  test "#read fails with a bad path" do
    {:error, _} = Lana.Config.read('some_path.tml')
  end

  test "#read is ok with a real path" do
    {:ok, _} = Lana.Config.read(fixture_path)
  end

  test "#read" do
    {:ok, record} = Lana.Config.read(fixture_path)
    assert record.title == "The Example book"
    assert length(record.content) == 9
  end
end
