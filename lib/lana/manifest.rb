require 'yaml'

module Lana
  class FileNotFound < Exception; end

  class Manifest
    attr_reader :path, :yaml

    def initialize(path)
      raise FileNotFound unless File.exists? path
      @path = path
      @yaml = digest(path)
    end

    def [](key)
      @yaml[key]
    end

    private
    def digest(path)
      YAML.load_file path
    end
  end
end
