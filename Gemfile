source 'https://rubygems.org'

gem 'rails', '4.1.4'
gem 'carrierwave',             '0.10.0'
gem 'fog',                     '1.29.0'
gem 'jquery-turbolinks'
gem 'mini_magick',             '3.8.0'
gem 'sprockets', '2.11'
gem 'will_paginate',           '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',       '3.2.0.0'
gem 'rack', '1.5.5'
gem 'net-ssh'
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



gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'


group :development, :test do
  gem 'sqlite3'
  gem 'minitest'
  gem 'thor'
 
  
end


# Add support for the MySQL
group :production, :mysql do
  gem 'mysql2', '~> 0.3.18'
end

group :develpment do
  gem 'spring'
end