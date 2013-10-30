require 'spec_helper'

describe Lana::Compiler do
  let(:subject) { Lana::Compiler }

  before do
    @manifest = Lana::Manifest.new(fixture_path)
    @compiler = subject.new(@manifest)
  end
  context 'book' do
    it 'can compile a book' do
      output_path = File.expand_path('../../tmp/output.pdf', __FILE__)
      base_path   = File.expand_path('../../fixtures/example_book', __FILE__)
      manifest    = Lana::Manifest.new(fixture_path('simple.json'))
      compiler    = subject.new(manifest, base_path)
      compiler.compile(output_path)
      expect(File.exists?(output_path)).to eq(true)
      FileUtils.rm(output_path)
    end
  end

  context '#initialize' do
    it 'can take manifest as an argument' do
      subject.new(@manifest)
    end

    it 'takes a base path' do
      manifest = Lana::Manifest.new(fixture_path('simple.json'))
      compiler = subject.new(manifest, 'example/')
    end
  end

  context '#full_path' do
    before do
      @simple_manifest = Lana::Manifest.new(fixture_path('simple.json'))
    end

    it 'creates a path relative to base_path' do
      compiler = subject.new(@simple_manifest, 'example/')
      expect(compiler.send(:full_path,'main.md')).to eq('example/main.md')

      compiler = subject.new(@simple_manifest, 'example')
      expect(compiler.send(:full_path,'main.md')).to eq('example/main.md')
    end
  end

  context '#compile' do
    it 'sends the pages list to pandoc' do
      pages = @manifest.pages
      @compiler.should_receive(:system).with("pandoc -o output.pdf #{pages.join(' ')}")
      @compiler.compile("output.pdf")
    end

    it 'sends the pages list with a base_path to pandoc' do
      manifest = Lana::Manifest.new(fixture_path('simple.json'))
      pages    = manifest.pages.map { |page| "example/#{page}" }
      compiler = subject.new(manifest, 'example/')

      compiler.should_receive(:system).with("pandoc -o output.pdf #{pages.join(' ')}")
      compiler.compile("output.pdf")
    end
  end
end
