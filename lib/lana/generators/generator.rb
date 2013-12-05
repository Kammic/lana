require 'lana/generators/options'

module Lana
  module Generators
    class FileNotFound < Exception; end
    class Generator
      attr_reader :paths, :output
      include Lana::Generators::Options

      def initialize(paths, output)
        @paths  = paths
        @output = output
      end

      def generate
        verify_paths_exist
        Kernel.system("pandoc #{options} -o #{output} #{paths.join(' ')}")
      end

      private
      def options
        ''
      end

      def verify_paths_exist
        paths.each do |path|
          if !File.exists?(path)
            raise Lana::Generators::FileNotFound.new(path)
          end
        end
      end


    end
  end
end
