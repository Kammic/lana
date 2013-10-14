require 'pandoc-ruby'

module Lana
  class Generator
    class << self
      def generate(options = {})
        options = options.with_indifferent_access
        options = default_options.merge(options)
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
        {format: :pdf, manifest: 'manifest.yml'}.with_indifferent_access
      end
    end
  end
end
