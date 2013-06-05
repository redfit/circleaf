ruby '2.0.0'
source 'https://rubygems.org'

gem 'rails', '4.0.0.rc1'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'haml-rails'
gem 'figaro'
gem 'warden'
gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'
gem 'enumerize', github: 'brainspec/enumerize', branch: 'rails4'
gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'

group :assets do
  gem 'sass-rails',   '~> 4.0.0.rc1'
  gem 'coffee-rails', '~> 4.0.0.rc1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'thin'
  gem 'foreman'
end

group :test, :development do
  gem 'sqlite3'
  # Rspec
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'delorean'
  gem 'shoulda-matchers'

  # Capybara
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'

  # Debug tool
  gem 'pry'
  gem 'tapp'
  gem 'awesome_print'
  gem 'spring', github: 'jonleighton/spring'

  # Testing tools
  gem 'database_cleaner', github: 'scottwillson/database_cleaner'
  gem "brakeman"

  # Capistrano
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'rvm-capistrano'

  # Guard
  gem 'guard-rspec', require: false
  gem 'guard-sprockets2'
  gem 'rb-fsevent', require: RUBY_PLATFORM.downcase =~ /darwin/ ? 'rb-fsevent' : false
end

group :production do
  gem 'pg'
  gem 'unicorn'
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end
