# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easyemail/version'

Gem::Specification.new do |spec|
  spec.name          = "easyemail"
  spec.version       = Easyemail::VERSION
  spec.authors       = ["TUITU"]
  spec.email         = ["1965972530@qq.com"]

  spec.summary       = %q{"easyemail"}
  spec.description   = %q{"send email in a simple way"}
  spec.homepage      = "https://github.com/hellotuitu/easyemail."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
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

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "yaml"
  spec.add_development_dependency "action_mailer"
  spec.add_development_dependency "active_support"
end
