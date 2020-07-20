require_relative 'lib/banken/matchers/version'

Gem::Specification.new do |spec|
  spec.name          = "banken-matchers"
  spec.version       = Banken::Matchers::VERSION
  spec.authors       = ["ichi"]
  spec.email         = ["ichi.ttht.1@gmail.com"]

  spec.summary       = %q{Rspec matchers for banken loyalties.}
  spec.description   = %q{Rspec matchers for banken loyalties.}
  spec.homepage      = "https://github.com/ichi/banken-matchers"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_dependency 'rspec', '~> 3.0'
end
