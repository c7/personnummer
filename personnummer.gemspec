# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "personnummer"
  s.version     = "0.0.8"
  s.authors     = ["Peter Hellberg", "Victor Koronen", "Sebastian Wallin"]
  s.email       = ["peter@c7.se"]
  s.homepage    = "https://github.com/c7/personnummer/"
  s.summary     = %q{Personnummer handles validation of Swedish personal identity numbers.}
  s.description = %q{Personnummer handles validation of Swedish personal identity numbers.}

  s.has_rdoc = false

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "timecop"
end
