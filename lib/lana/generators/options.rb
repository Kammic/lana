module Lana
  module Generators
    module Options

      def default_options
        {
          latex_engine: '--latex-engine=xelatex',
          geometry:     '-V geometry:margin=1in',
          format:       '-f markdown_github',
          other:        '--toc -N',
          math:         '--mathjax',
        }
      end

      def option(key)
        default_options[key]
      end
    end
  end
end
