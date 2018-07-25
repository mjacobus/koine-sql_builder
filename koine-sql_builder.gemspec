# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'koine/sql_builder/version'

Gem::Specification.new do |spec|
  spec.name          = 'koine-sql_builder'
  spec.version       = Koine::SqlBuilder::VERSION
  spec.authors       = ['Marcelo Jacobus']
  spec.email         = ['marcelo.jacobus@gmail.com']

  spec.summary       = 'SQL builder for writing SQL queries'
  spec.description   = 'SQL builder for writing SQL queries'
  spec.homepage      = 'https://github.com/mjacobus/koine-sql_builder'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'object_comparator'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'reek', '~> 5.0.2'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.58.0'
  spec.add_development_dependency 'simplecov'
end
