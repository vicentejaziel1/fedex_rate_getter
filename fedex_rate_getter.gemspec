require_relative 'lib/fedex_rate_getter/version'
require_relative "lib/fedex_rate_getter/version"
require_relative "lib/fedex_rate_getter/connection"
require_relative "lib/fedex_rate_getter/formatter/body"
require_relative "lib/fedex_rate_getter/formatter/response"


Gem::Specification.new do |spec|
  spec.name          = "fedex_rate_getter"
  spec.version       = FedexRateGetter::VERSION
  spec.authors       = ["Write your name"]
  spec.email         = ["Write your email address"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "http://github.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'libxml-ruby', '~> 3.2.3'
  spec.add_runtime_dependency 'activesupport', '~> 5.0'
  spec.add_runtime_dependency 'faraday', '~> 0.9.2'
end
