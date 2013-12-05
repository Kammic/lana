require 'spec_helper'

describe Lana::Generators::Mobi do
  let(:subject)  { Lana::Generators::Mobi }
  let(:page_one) { fixture_path('chapters/chapter1.md') }
  let(:page_two) { fixture_path('chapters/chapter2.md') }

  let(:output_path) do
    output_path = File.join(File.dirname(__FILE__), '..', '..')
    output_path = File.join(output_path, 'tmp/output.epub')
    output_path = File.expand_path(output_path)
  end

  after do
    FileUtils.rm_rf(output_path) if File.exists?(output_path)
  end

  it 'generates an output' do
    Kernel.should_receive(:system) do |cmd|
    	expect(cmd).to match page_one
    	expect(cmd).to match page_two
    	expect(cmd).to match output_path 
		end

    gen = subject.new([page_one, page_two], output_path)
    gen.generate
  end

end
