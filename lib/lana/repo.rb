require 'grit'

module Lana
  class Repo
    def self.clone(remote, local = '/tmp/some_path', branch = 'master')
      Grit::Git.new(local).clone({branch: branch}, remote, local)
    end
  end
end
