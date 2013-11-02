#!/usr/bin/env gem build
require File.expand_path("../lib/lana/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name          = "lana"
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

  s.add_dependency("pandoc-ruby", "~> 0.7")
  s.add_dependency("grit")

  s.add_development_dependency("rake", "~> 10.1")
  s.add_development_dependency("rspec", "~> 2.14")
  s.add_development_dependency("pry")
end
