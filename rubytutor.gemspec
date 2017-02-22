# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubytutor/version'

Gem::Specification.new do |spec|
  spec.name          = "rubytutor"
  spec.version       = RubyTutor::VERSION
  spec.authors       = ["Sun-Li Beatteay"]
  spec.email         = ["sjbeatteay@gmail.com"]

  spec.summary       = %q{An irb tool to help new developers use Ruby}
  spec.description   = %q{A console tool to help new developers and developers new to Ruby.}
  spec.homepage      = "https://github.com/sunny-b/RubyTutor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  s.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters"
end
