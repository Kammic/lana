defrecord ConfigRecord, title: nil, content: nil
defmodule Lana.Config do

  def read(path) do
    {status, content} = load_file(path)

    if(status == :error) do
      { :error, nil }
    else
      { :ok, parse_content(Enum.first(content))}
    end
  end

  def parse_content(content) do
    {_, title}   = Enum.find(content, fn({key, _}) -> key == "title" end)
    {_, content} = Enum.find(content, fn({key, _}) -> key == "content" end)
    ConfigRecord.new title: title, content: content
  end

  def load_file(path) do
    :yaml.load_file(path)
  end

end
