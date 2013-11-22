require 'lana/generators/generator'

module Lana
  module Generators
    class PDF < Lana::Generators::Generator
      def options
        options = []
        options << append_file
        options << option(:other)
        options << option(:format)
        options << option(:geometry)
        options << option(:latex_engine)
        options << option(:math)
        #options << "--variable mainfont=Georgia"
        #options << "--variable sansfont=Arial"
        #options << "--variable monofont=\"Bitstream Vera Sans Mono\""
        #options << "--variable fontsize=14pt"
        options.join(' ')
      end

      def append_file
        "-H #{File.expand_path('../../../pandoc/append_file.tex', __FILE__)}"
      end
    end
  end
end
