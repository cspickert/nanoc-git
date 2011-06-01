# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'nanoc-git'
  s.version     = '0.0.1'
  s.authors     = ["Cameron Spickert"]
  s.email       = ["cspicker@gmail.com"]
  s.homepage    = "https://github.com/cspicker/nanoc-git"
  s.summary     = "A Nanoc3 deployer for git"
  s.description = "A Nanoc3 extension that adds a Git deployer and associated rake task."

  s.rubyforge_project = "nanoc-git"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('nanoc', '>= 3.1.6')
  s.add_runtime_dependency('git', '>= 1.2.5')
end
