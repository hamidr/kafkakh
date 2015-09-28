source 'https://rubygems.org'

gem 'rails', '4.1.4'

### OpenShift Online changes:

# Fix the conflict with the system 'rake':
gem 'rake', '~> 0.9.6'

# Support for databases and environment.
# Use 'sqlite3' for testing and development and mysql and postgresql
# for production.
#
# To speed up the 'git push' process you can exclude gems from bundle install:
# For example, if you use rails + mysql, you can:
#
# $ rhc env set BUNDLE_WITHOUT="development test postgresql"
#
group :development, :test do
  gem 'minitest'
  gem 'thor'
  gem 'byebug'
end

group :production, :postgresql do
  gem 'pg'
end

gem 'kaminari' #pagination
gem 'pg_search' #searching

gem 'rails_param' 


### / OpenShift changes

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'bootstrap-sass'

gem 'angularjs-rails'
gem 'angular-ui-bootstrap-rails'


# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2' 
gem 'unicorn'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

