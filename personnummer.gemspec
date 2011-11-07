# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "personnummer"
  s.version     = "0.0.3"
  s.date        = "2008-08-06"
  s.authors     = ["Peter Hellberg"]
  s.email       = ["peter@c7.se"]
  s.homepage    = "http://c7.se/code/personnummer"
  s.summary     = %q{Personnummer handles validation of Swedish personal identity numbers.}
  s.description = %q{Personnummer handles validation of Swedish personal identity numbers.}

  s.has_rdoc = false

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
