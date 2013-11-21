module Lana
  class Compiler
    attr_reader :base_path

    def initialize(manifest_path, base_path = '')
      @base_path  = add_slash(base_path)
      @manifest   = Manifest.new("#{@base_path}#{manifest_path}")
    end

    def compile(output_path)
      pages = @manifest.pages.map { |page| full_path(page) }
      system("pandoc #{options} -o #{output_path} #{pages.join(' ')}")
    end

    private
    def options
      options = []
      options << append_file
      options << "-f markdown_github"
      options << "--toc"
      options << "-N"
      options << "-V geometry:margin=1in"
      options << "--variable mainfont=Georgia"
      options << "--variable sansfont=Arial"
      options << "--variable monofont=\"Bitstream Vera Sans Mono\""
      options << "--variable fontsize=14pt"
      options << "--latex-engine=xelatex"
      options.join(' ')
    end

    def append_file
      "-H #{File.expand_path('../../pandoc/append_file.tex', __FILE__)}"
    end

    def add_slash(path)
      return path if path == ''
      return path if path.end_with?('/')
      "#{path}/"
    end

    def full_path(file)
      "#{@base_path}#{file}"
    end
  end
end
