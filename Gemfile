source 'https://rubygems.org'
gem 'halite', git: 'https://github.com/poise/halite'
gem 'poise', git: 'https://github.com/poise/poise'

group :lint do
  gem 'foodcritic'
  gem 'rubocop'
end

group :development do
  gem 'rake'
  gem 'stove'
end

group :unit do
  gem 'berkshelf'
  gem 'chefspec'
  gem 'coveralls', require: false
end

group :integration do
  gem 'serverspec'
end

group :kitchen_common do
  gem 'test-kitchen', '~> 1.4'
end

group :kitchen_vagrant do
  gem 'kitchen-vagrant'
end
