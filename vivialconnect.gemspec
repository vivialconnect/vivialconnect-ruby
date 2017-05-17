# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vivialconnect/version'

# uncomment and make your .env file if you want to use it in development
# require 'dotenv/load'

Gem::Specification.new do |spec|
  spec.name          = "vivialconnect"
  spec.version       = Vivialconnect::VERSION
  spec.authors       = ["Justin LeFurjah"]
  spec.email         = ["jlefurjah@vivial.net"]

  spec.summary       = %q{This is an API wrapper gem for integrating with the Vivial Connect text messaging API. }
  spec.description   = %q{VivialConnect is a simple SMS/MMS API. It's designed specifically for developers seeking a simple, affordable and scalable messaging solution. For more info visit: https://www.vivialconnect.net/}
  spec.homepage      = "https://vivialconnect.github.io/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.files = Dir['lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~>0.11.0'
  spec.add_dependency 'addressable', '~> 2.5', '>= 2.5.0'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'dotenv', '~> 2.2', '>= 2.2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0'

  spec.required_ruby_version = '>= 2.0.0'
end
