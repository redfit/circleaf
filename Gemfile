ruby '2.0.0'
source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'haml-rails'
gem 'figaro'
gem 'warden'
gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'
gem 'bootstrap_helper', github: 'xdite/bootstrap-helper', branch: 'support-rails-40'
gem 'enumerize', github: 'brainspec/enumerize', branch: 'rails4'
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'simple_form', '3.0.0.rc'
gem 'active_decorator'
gem 'rails-i18n'
gem 'pusher'
gem 'em-http-request'
gem 'redcarpet'
gem 'coderay'
gem 'validates_email_format_of'
gem 'authority'
gem 'kaminari'
gem 'carrierwave'
gem 'fog'
gem 'rmagick'

group :assets do
  gem 'sass-rails',   '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'thin'
  gem 'foreman'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
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
  gem "database_cleaner", '1.0.0.RC1'
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

  # Reset DB
  gem 'rails-db-resetup'
end

group :production do
  gem 'pg'
  gem 'thin'
  gem 'rails_12factor'
end
