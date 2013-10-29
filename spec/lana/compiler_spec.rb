require 'spec_helper'

describe Lana::Compiler do
  let(:subject) { Lana::Compiler }

  before do
    @manifest = Lana::Manifest.new(fixture_path)
    @compiler = subject.new(@manifest)
  end

  context '#initialize' do
    it 'can take manifest as an argument' do
      subject.new(@manifest)
    end
  end

  context '#compile' do
    it 'sends the pages list to pandoc' do
      pages = @manifest.pages
      @compiler.should_receive(:system).with("pandoc -o output.pdf #{pages.join(' ')}")
      @compiler.compile("output.pdf")
    end
  end
end
