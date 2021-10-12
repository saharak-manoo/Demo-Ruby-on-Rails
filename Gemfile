source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6', '>= 5.1.6.1'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Easy file attachment management for ActiveRecord
gem 'paperclip', '~> 6.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'flag-icons-rails'

gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap4-datetime-picker-rails' # https://tempusdominus.github.io/bootstrap-4/

# order matters
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'bootstrap-tagsinput-rails'

# soft delete
gem 'paranoia', '~> 2.2'
# Flexible authentication solution for Rails with Warden
gem 'devise'

# Rails I18n translations on the JavaScript.
gem 'i18n-js'
gem 'awesome_print', require: 'ap'

# boostrap confirm dialog
gem 'data-confirm-modal'

# Decorators/View-Models for Rails Applications
gem 'draper'

gem 'protokoll'

# calendar
gem 'fullcalendar-rails'
gem 'momentjs-rails'

gem 'letter_opener_web', '~> 1.0'
gem 'letter_opener'

gem 'cancancan'

# gem 'rails_admin', '~> 1.3'
