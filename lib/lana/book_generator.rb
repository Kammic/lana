require 'grit'

module Lana
  class BookGenerator
    attr_reader :local, :remote, :branch, :manifest_file, :output

    def initialize(options = {})
      @options       = default_options.merge(options)
      @local         = @options[:local]
      @remote        = @options[:remote]
      @branch        = @options[:branch]
      @manifest_file = @options[:manifest_file]
      @output        = @options[:output]
    end

    def generate(const)
      clone_repo
      generator = const.new(pages, output)
      generator.generate
    end

    private
    def clone_repo
      grit_repo.clone({branch: branch}, remote, local)
    end

    def pages
      manifest = Manifest.new("#{@local}/#{@manifest_file}")
      manifest.pages.map { |page| full_path(page) }
    end

    def full_path(file)
      "#{@local}/#{file}".gsub(/\/\/+/, '/')
    end

    def grit_repo
      Grit::Git.new(local)
    end

    def default_options
      {
        branch: 'master',
        local:  '/tmp/tmp_clone',
        manifest_file: 'manifest.json',
        output: '/tmp/output.pdf'
      }
    end
  end
end
