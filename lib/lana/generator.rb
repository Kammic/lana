require 'pandoc-ruby'

module Lana
  class Generator
    attr_reader :options

    def initialize(options = {})
      @options = default_options.merge(options)
    end

    def generate
     clone(options[:remote], options[:local])
     manifest = manifest("#{options[:local]}/#{options[:manifest]}")
     pages    = pages(manifest, options[:local])
     system("pandoc -o #{options[:output]} #{pages.join(' ')}")
    end

    private
    def clone(remote, local)
      Repo.clone(remote, local)
    end

    def manifest(path)
      Manifest.new path
    end

    def pages(manifest, prefix)
      manifest["pages"].map do |_, path|
        "#{prefix}/#{path}"
      end
    end

    def default_options
      {format: :pdf, manifest: 'manifest.yml'}
    end
  end
end
