# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/gems/version'

Gem::Specification.new do |spec|
  spec.name          = "git-gems"
  spec.version       = Git::Gems::VERSION
  spec.authors       = ["Hiroshi IKEGAMI"]
  spec.email         = ["hiroshi.ikegami@magicdrive.jp"]
  spec.summary       = %q{rubygem utililty: bundler and git wrapper}
  spec.description   = %q{rubygem utililty: bundler and git wrapper}
  spec.homepage      = "https://github.com/magicdrive/ruby-git-gems"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.0"
  spec.add_runtime_dependency "bundler"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
end
