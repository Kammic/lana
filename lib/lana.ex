defmodule Lana do

  def generate(input, output, :pdf) do
    Lana.Git.clone(input)
    {:ok, config} = Lana.Config.read "#{Lana.Git.clone_location}\/#{manifest_file}"
    {:ok, files}  = files_list(config.content)

    files = Enum.map(files, fn(x) -> "#{Lana.Git.clone_location}/#{x}" end)
    files_string = Enum.join(files, " ")
  end

  def files_list(content) do
    list = Enum.map(content, fn({_, v}) -> v end)
    {:ok, list}
  end

  defp manifest_file, do: "manifest.yml"

end
