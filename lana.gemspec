#!/usr/bin/env gem build
require File.expand_path("../lib/lana/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name          = "Lana"
  s.authors       = ["Sumeet Singh"]
  s.email         = "ortuna@gmail.com"
  s.homepage      = "http://www.padrinorb.com"
  s.description   = "Generate a book from a git repo"
  s.summary       = "Genearte a book give a git repo"
  s.version       = Lana::Version
  s.date          = Time.now.strftime("%Y-%m-%d")
  s.files         = `git ls-files`.split("\n") | Dir.glob("{lib}/**/*")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options  = ["--charset=UTF-8"]
  s.required_rubygems_version = ">= 1.3.6"
  #s.add_dependency("padrino-core", "~> 0.11.0")
  #s.add_dependency("padrino-helpers", "~> 0.11.0")
end
