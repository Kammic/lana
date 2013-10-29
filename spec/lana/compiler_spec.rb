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

  context '#page_list' do
    it 'can get a flat array of files/pages' do
      pages = @compiler.send(:page_list)
      expected_pages = 
        ["01-introduction/01-chapter1.markdown",
         "02-introduction/01-chapter1.markdown",
         "03-introduction/01-chapter99.markdown",
         "04-introduction/01-chapter42.markdown",
         "05-git-basics/01-chapter2.markdown",
         "06-git-branching/01-chapter3.markdown",
         "07-git-server/01-chapter4.markdown",
         "08-git-tools/01-chapter6.markdown",
         "09-customizing-git/01-chapter7.markdown",
         "10-git-and-other-scms/01-chapter8.markdown",
         "11-git-internals/01-chapter9.markdown"]
      expect(pages.count).to eq(11)
      expected_pages.each do |page|
        expect(pages.include?(page)).to eq(true)
      end
    end
  end

  context '#compile' do
    it 'sends the pages list to pandoc' do
      pages = @compiler.send(:page_list)
      @compiler.should_receive(:system).with("pandoc -o output.pdf #{pages.join(' ')}")
      @compiler.compile("output.pdf")
    end
  end
end
