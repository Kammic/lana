defmodule Lana.Git do
  use Geef

  def head do
    repo = Repository.open!(".")
    Reference.lookup!(repo, "HEAD") |> Reference.resolve!
  end

  def clone(url) do
    output = System.cmd("git clone #{url} #{clone_location}")
    if String.starts_with?(output, "fatal") do
      :error
    else
      :ok
    end
  end


  def clone_location do
    "/tmp/example"
  end
end
