require 'yaml'

module Lana
  class FileNotFound < Exception; end

  class Manifest
    attr_reader :path

    def initialize(path)
      raise FileNotFound unless File.exists? path
      @path = path
    end

    private
    def digest(path)
      YAML.load_file path
    end
  end
end
