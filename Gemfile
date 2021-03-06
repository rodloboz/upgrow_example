# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.1.0', '>= 6.1.3'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'shrine', '~> 3.0'
gem 'sidekiq'
gem 'sidekiq-failures', '~> 1.0'
gem 'turbo-rails'
gem 'webpacker', '~> 5.0'

gem 'brakeman', require: false
gem 'bundle-audit', require: false

gem 'devise'

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener_web'
  gem 'listen'
  gem 'overcommit', require: false
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'database_cleaner-redis'
  gem 'fuubar'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-github', require: false # Rspec formatter to post output as github annotations
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-material', require: false
  gem 'webmock', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
