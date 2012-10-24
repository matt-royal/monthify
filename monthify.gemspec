# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monthify/version'

Gem::Specification.new do |gem|
  gem.name          = "monthify"
  gem.version       = Monthify::VERSION
  gem.authors       = ["Matt Royal"]
  gem.email         = ["mroyal@gmail.com"]
  gem.description   = %q{The missing Month class every project ends up needing}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/matt-royal/monthify"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('activesupport')
end
