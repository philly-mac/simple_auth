# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_auth/version"
require "date"

Gem::Specification.new do |s|
  s.name          = "simple_auth"
  s.version       = SimpleAuth::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Philip MacIver"]
  s.email         = ["philip@ivercore.com"]
  s.homepage      = "https://github.com/philly-mac/simple-auth"
  s.summary       = %q{Very simple authentication}
  s.description   = %q{Very simple authentication}
  s.date          = Date.today.to_s

  s.rubyforge_project = "simple_auth"

  s.add_development_dependency "rake"
  s.add_development_dependency "bacon"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

