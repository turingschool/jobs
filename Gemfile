source 'https://rubygems.org'
fury_url = ENV['GEMFURY_URL']
source fury_url if fury_url

ruby '2.1.2'
gem 'rails', '4.1.8'
gem 'pg'
gem 'sass-rails', '4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'thin'
gem 'haml'
gem 'redcarpet'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'deject'                                           # dependency injection
gem "twitter-bootstrap-rails"

group :development, :test do
  gem 'minitest'
  gem 'minitest-emoji'
  gem 'capybara'
  gem 'pry'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end
