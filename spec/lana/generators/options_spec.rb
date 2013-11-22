require 'spec_helper'

describe Lana::Generators::Options do
  class ExampleOptions
    include Lana::Generators::Options
  end

  let(:subject) { ExampleOptions.new }

  it 'can retreive some defualt options' do
    latex_engine = '--latex-engine=xelatex'
    expect(subject.option(:latex_engine)).to eq(latex_engine)
  end

end
