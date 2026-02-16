source 'https://rubygems.org'

ruby '3.2.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rake', '~> 13.0'
gem 'rack-attack'
gem 'rufus-scheduler'
gem 'dotenv-rails', require: 'dotenv/load'
gem 'rails-html-sanitizer'

# api auth
gem 'omniauth'
gem 'omniauth-oauth2', '~> 1.8'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'

# api
gem 'searchkick'
gem 'kaminari'
gem 'jbuilder'
gem 'rack-cors'

# server
gem 'rails', '~> 8.0.0'
gem 'loofah'
gem 'puma', '>= 5.0'

# assets
gem 'sprockets-rails'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'therubyracer'
gem 'terser'
gem 'sassc-rails'

# db
gem 'mysql2', '~> 0.5'

group :tools do
  gem 'squasher'
end

group :development, :test do
  gem 'debug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
