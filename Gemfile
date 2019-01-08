source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'activejob-traffic_control'
gem 'connection_pool'
gem 'devise'
gem 'dotenv-rails'
gem 'geocoder'
gem 'google-api-client', '~> 0.11'
gem 'httparty', '~> 0.15.6'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.2'
gem 'redcarpet'
gem 'redis', '~> 3.2'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'sucker_punch'
gem 'uglifier', '>= 1.3.0'
gem 'vacuum'

group :development, :test do
  gem 'bundler-audit', '>= 0.1'
  gem 'bundler-stats', '>= 1.1'
  gem 'capybara', '~> 2.13'
  gem 'pry'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock', '~> 3.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
