require 'spec_helper'

describe Lana::BookGenerator do
  let(:subject) { Lana::BookGenerator }
  context '#initialize' do
    it 'takes a git repo as an argument' do
      compiler = subject.new(remote: 'git@github.com:Kammic/lana.git',
                             local: '/tmp',
                             branch: 'dev',
                             manifest_file: 'file',
                             output: 'output.pdf')
      expect(compiler.remote).to eq('git@github.com:Kammic/lana.git')
      expect(compiler.local).to eq('/tmp')
      expect(compiler.branch).to eq('dev')
      expect(compiler.manifest_file).to eq('file')
      expect(compiler.output).to eq('output.pdf')

      compiler = subject.new(remote: 'git@github.com:Kammic/lana.git',
                             local: '/tmp')
      expect(compiler.branch).to eq('master')
      expect(compiler.manifest_file).to eq('manifest.json')
      expect(compiler.output).to eq('/tmp/output.pdf')
    end
  end

  context '#clone_repo' do
    it 'calls clone on grit' do
      double    = double().as_null_object
      generator = subject.new(remote: 'git@github.com:Kammic/lana.git',
                              local: '/tmp')
      generator.stub(:grit_repo).and_return(double)
      double.should_receive(:clone).with({branch: 'master'}, 
                                         'git@github.com:Kammic/lana.git',
                                         '/tmp')
      generator.send(:clone_repo)
    end
  end

  context '#generate' do
    let(:tmp_repo_path){ File.expand_path('../../tmp/clone', __FILE__) }
    let(:tmp_book_path){ File.expand_path('../../tmp/book.pdf', __FILE__) }
    let(:fixture_repo) { File.expand_path('../../fixtures/example_book', __FILE__) }

    it 'inits the object with the right paths and output' do
      pdf_double  = double()
      pdf_double.should_receive(:new) do |paths, output_path|
        expect(paths).to include(fixture_path('chapters/chapter1.md'))
        expect(paths).to include(fixture_path('chapters/chapter2.md'))
        expect(output_path).to eq('output.pdf')
        pdf_double
      end
      pdf_double.should_receive(:generate)

      generator = subject.new(remote: 'git@github.com:Kammic/lana.git',
                              local: fixture_path(''),
                              branch: 'dev',
                              manifest_file: 'simple.json',
                              output: 'output.pdf')

      generator.should_receive(:clone_repo).and_return true
      generator.generate(pdf_double)
    end
  end
end
