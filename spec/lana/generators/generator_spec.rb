require 'spec_helper'

describe Lana::Generators::Generator do
  class ExampleGenerator < Lana::Generators::Generator

  end

  let(:subject)  { ExampleGenerator }
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

  it 'sets the paths and output' do
    gen = subject.new(['xyz.md', 'abc.md'], 'output.pdf')
    expect(gen.paths).to eq(['xyz.md', 'abc.md'])
    expect(gen.output).to eq('output.pdf')
  end

  it 'generates an output' do
    gen = subject.new([page_one, page_two], output_path)
    gen.generate
    expect(File.exists?(output_path)).to eq(true)
  end

  it 'raises when a file is not found' do
    gen = subject.new(['some_path.md', page_two], output_path)
    expect { gen.generate }.to raise_error(Lana::Generators::FileNotFound)
  end
end
