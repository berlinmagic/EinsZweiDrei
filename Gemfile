source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end



gem 'active_model_serializers', "0.9.5"



# enumerized string fields
gem 'enumerize'

# non-stupid-assets
gem "non-stupid-digest-assets"

# pastel colors for strings
gem 'hashtel'

# magic-styles
gem "magic_stylez",       ">= 0.0.0.98"

# magic-locales
gem "magic_locales",      ">= 0.0.20"

# magic-addresses
gem "magic_addresses",    ">= 0.0.40"

# file-uploads
gem 'jquery.fileupload-rails'

# jQuery-ui (if needed)
gem 'jquery-ui-rails'

# Error Handling
gem 'rollbar'

## Authentication / Authorization
gem 'devise'
gem 'cancancan'
gem "omniauth-facebook"
gem "omniauth-google-oauth2", "~> 0.4.0"

## image handling
gem 'dragonfly',          ">= 1.0.4"

# faster json
gem 'oj'

# faster xml
gem 'ox'

# inline email css
gem 'roadie', '~> 2.4'

## App-Server
gem 'thin'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  # open emails in a new browser-window
  gem 'letter_opener'
  # much better and more useful error page
  gem "better_errors"
  gem 'quiet_assets'                        # => shortened log from asset-pipeline
  gem 'guard-livereload', require: false
  ## deployment
  gem 'capistrano'
  gem 'magic_recipes_two', '>= 0.0.32'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'ffaker'
end

