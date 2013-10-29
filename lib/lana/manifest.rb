require 'json'

module Lana
  class FileNotFound < Exception; end
  class InvalidManifest < Exception; end

  class Manifest
    attr_reader :path

    def initialize(path)
      raise FileNotFound unless File.exists? path
      @path   = path
      @config = parse_json
    end

    def [](key)
      @config[key]
    end

    private
    def read_file
      File.read(@path)
    end

    def parse_json
      JSON.parse(read_file)
    rescue JSON::ParserError => e
      raise InvalidManifest
    end
  end
end
