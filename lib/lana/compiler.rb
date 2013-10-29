module Lana
  class Compiler
    def initialize(manifest)
      @manifest = manifest
    end

    def compile(output_path)
      pages = @manifest.pages
      system("pandoc -o #{output_path} #{pages.join(' ')}")
    end
  end
end
