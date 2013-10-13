defmodule LanaGitTest do
  use ExUnit.Case

  teardown do
    System.cmd("rm -rf #{Lana.Git.clone_location}")
    :ok
  end

  test "#clone doesn't clone on a bad URL" do
    assert Lana.Git.clone('something_unknown') == :error
  end

  test "#clone a github repo" do
    assert Lana.Git.clone('git@github.com:Ortuna/progit-bana.git') == :ok
  end
end
