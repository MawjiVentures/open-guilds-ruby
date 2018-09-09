
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "open_guilds/version"

Gem::Specification.new do |spec|
  spec.name          = "open-guilds"
  spec.version       = OpenGuilds::VERSION
  spec.authors       = ["OpenGuilds"]
  spec.email         = ["nolan@openguilds.com"]

  spec.summary       = %q{A ruby wrapper for Openguilds API.}
  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = "https://openguilds.com"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "dotenv", "~> 2.5.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.4.2"
  spec.add_development_dependency "vcr", "~> 3.4.2"

  spec.add_dependency "faraday", "~> 0.15.2"
  spec.add_dependency "money", "~> 6.12.0"
end
