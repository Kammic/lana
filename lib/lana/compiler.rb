module Lana
  class Compiler
    def initialize(manifest)
      @manifest = manifest
    end

    def compile(output_path)
      system("pandoc -o #{output_path} #{page_list.join(' ')}")
    end

    private
    def page_list
      recursive_page_list(@manifest["pages"]).flatten
    end

    def recursive_page_list(manifest_pages)
      [].tap do |pages|
        manifest_pages.each do |_, value|
          if value.respond_to? :each
            pages << recursive_page_list(value)
          else
            pages << value
          end
        end
      end
    end

  end
end
