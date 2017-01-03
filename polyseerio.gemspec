Gem::Specification.new do |gem|
  gem.name        = 'polyseerio'
  gem.version     = '0.0.2'
  gem.authors     = ['Nicolas Feigenbaum']
  gem.email       = ['support@kognizant.com']
  gem.description = 'The official Polyseer.io SDK for Ruby.'
  gem.summary     = 'Polyseer.io SDK for Ruby.'
  gem.homepage    = 'https://github.com/kgnzt/polyseerio-ruby'
  gem.files      += Dir['lib/**/*.rb']
  gem.files      += [
    '.gitignore',
    '.rubocop.yml',
    'Gemfile',
    'HISTORY.md',
    'LICENSE',
    'Makefile',
    'README.md',
    'polyseerio.gemspec'
  ]

  gem.add_runtime_dependency('concurrent-ruby', ['1.0.2'])
  gem.add_runtime_dependency('functional-ruby', ['1.3.0'])
  gem.add_runtime_dependency('inflection', ['1.0.0'])
  gem.add_runtime_dependency('rest-client', ['2.0.0'])

  gem.add_development_dependency('rake', ['12.0.0'])
  gem.add_development_dependency('rspec', ['3.5.0'])
  gem.add_development_dependency('rubocop', ['0.46.0'])

  gem.require_paths = ['lib']
  gem.license       = 'MIT'
end
