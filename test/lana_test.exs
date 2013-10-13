defmodule LanaTest do
  use ExUnit.Case

  teardown do
    File.rm_rf "/tmp/example"
    :ok
  end

  test "#generate" do
    Lana.generate("git@github.com:Ortuna/progit-bana.git", "/tmp/example/output.pdf", :pdf)
    assert File.exists? "/tmp/example/output.pdf"
  end

  test "#files_list" do
    files_list = [
                  {"first", "markdown.md"},
                  {"first", "markdown1.md"},
                  {"first", "markdown2.md"},
                  {"first", "markdown3.md"},
                 ]
    {:ok, list} = Lana.files_list(files_list)
    assert list
            == ["markdown.md", "markdown1.md", "markdown2.md", "markdown3.md"]
  end
end
