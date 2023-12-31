# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rswag-api', '~> 2.11.0'
gem 'rswag-ui', '~> 2.11.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
gem 'redis-client', '~> 0.17.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/
# active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'
gem 'jwt_sessions', '~> 3.2.1'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/
# active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'factory_bot_rails', '~> 6.2.0'
gem 'jsonapi-serializer', '~> 2.2.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'aws-sdk-s3', '~> 1.14'
gem 'image_processing', '~> 1.12.2'
gem 'pagy', '~> 6.1'
gem 'rack', '~> 2.2'
gem 'rack-cors'
gem 'shrine', '~> 3.0'

group :development, :test do
  gem 'dotenv-rails', '~> 2.8.1'
  gem 'faker', '~> 3.2.1'
  gem 'ffaker', '~> 2.23'
  gem 'json_matchers', '~> 0.11.1'
  gem 'pry', '~> 0.14.2'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rswag-specs', '~> 2.11.0'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.22.0'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
