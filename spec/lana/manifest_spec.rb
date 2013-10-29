require 'spec_helper'

describe Lana::Manifest do
  let(:subject) { Lana::Manifest }

  before do 
    @manifest = manifest
  end

  context '#initialize' do
    it 'throws an error with an unkown file' do
      expect {
        Lana::Manifest.new('/some/unkown/path')  
      }.to raise_error(Lana::FileNotFound)
    end

    it 'knows its own path' do
      manifest = Lana::Manifest.new(fixture_path)
      expect(manifest.path).to eq(fixture_path)
    end
  end

  context '#read_file' do
    it 'can read a JSON file' do
      content = @manifest.send(:read_file)
      expect(content).to_not be_nil
    end
  end

  context '#parse_json' do
    it 'raises InvalidManifest when there is invalid json' do
      expect {
        manifest = Lana::Manifest.new('spec/fixtures/example_book/invalid.json')
        manifest.send(:parse_json)
      }.to raise_error(Lana::InvalidManifest)
    end

    it 'can parse the string into JSON' do
      json  = @manifest.send(:parse_json)
      expect(json["pages"]).to_not be_nil
    end
  end

  context '#[]' do
    it 'can read from the JSON hash' do
      expect(@manifest["title"]).to eq("Some Title")
      expect(@manifest["cover_image"]).to eq("assets/cover.jpg")
      expect(@manifest["pages"]).to_not be_nil
    end
  end
end
