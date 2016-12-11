Gem::Specification.new do |gem|
  gem.name        = 'polyseerio'
  gem.version     = '0.0.1'
  gem.authors     = ['Nicolas Feigenbaum']
  gem.email       = ['support@kognizant.com']
  gem.description = 'The official Polyseer.io SDK for Ruby.'
  gem.summary     = 'Polyseer.io SDK for Ruby.'
  gem.homepage    = 'https://github.com/kgnzt/polyseerio-ruby'
  gem.files      += Dir['lib/**/*.rb']

  gem.require_paths = ['lib']
  gem.license       = 'MIT'
end
