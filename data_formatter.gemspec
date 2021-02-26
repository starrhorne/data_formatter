lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "data_formatter/version"

Gem::Specification.new do |spec|
  spec.name = "data_formatter"
  spec.version = DataFormatter::VERSION
  spec.authors = ["Starr Horne"]
  spec.email = ["snhorne@gmail.com"]
  spec.description = "Format data for display"
  spec.summary = "Format data for display"
  spec.homepage = ""
  spec.license = "All rights reserved"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"
  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.3"
  spec.add_development_dependency "ZenTest"
  spec.add_development_dependency "autotest-spec"
  spec.add_development_dependency "autotest-suffix"
end
