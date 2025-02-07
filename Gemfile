# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.2.2', '>= 7.2.2.1'
gem 'sprockets-rails'
gem 'sqlite3', '>= 1.4'
gem 'stimulus-rails'
gem 'turbo-rails'

gem 'simple_form'
gem 'slim-rails'

group :development, :test do
  gem 'debug', platforms: %i[mri], require: 'debug/prelude'
  gem 'faker'
end

group :development do
  gem 'brakeman', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails-omakase', require: false
  gem 'rubocop-slim', require: false
  gem 'slim_lint', require: false
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
