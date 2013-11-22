require 'spec_helper'

describe Lana::Generators::PDF do
  let(:subject)  { Lana::Generators::PDF }
  let(:page_one) { fixture_path('chapters/chapter1.md') }
  let(:page_two) { fixture_path('chapters/chapter2.md') }

  let(:output_path) do
    output_path = File.join(File.dirname(__FILE__), '..', '..')
    output_path = File.join(output_path, 'tmp/output.pdf')
    output_path = File.expand_path(output_path)
  end

  after do
    FileUtils.rm_rf(output_path) if File.exists?(output_path)
  end

  xit 'generates an output' do
    gen = subject.new([page_one, page_two], output_path)
    gen.generate
    expect(File.exists?(output_path)).to eq(true)
  end

end
