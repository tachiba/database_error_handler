# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'database_error_handler/version'

Gem::Specification.new do |spec|
  spec.name          = "database_error_handler"
  spec.version       = DatabaseErrorHandler::VERSION
  spec.authors       = ["Takashi CHIBA"]
  spec.email         = ["contact@takashi.me"]
  spec.summary       = %q{Handle database errors for ActiveRecord.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/tachiba/database_error_handler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.3"
end
