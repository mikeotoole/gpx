source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.2'

group :production do
  gem 'pg'
  gem 'thin'
  gem 'newrelic_rpm'
end

gem 'haml'
gem 'ox'
gem 'rabl', '~> 0.6.0'
gem 'yajl-ruby', :require => 'yajl'
gem 'kaminari'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bourbon'
end

gem 'jquery-rails'
gem 'backbone-rails'
gem 'handlebars_assets'

gem 'execjs'

gem 'rubyzip'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'quiet_assets'
end
