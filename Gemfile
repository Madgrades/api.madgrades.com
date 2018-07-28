source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rack-throttle'
gem 'rufus-scheduler'
gem 'dotenv'
gem 'dotenv-rails'
gem 'rails-html-sanitizer', '~> 1.0.4'

# api auth
gem 'omniauth'
gem 'omniauth-oauth2', '~> 1.4.0'
gem 'omniauth-github'

# api
gem 'searchkick'
gem 'kaminari'
gem 'jbuilder'
gem 'rack-cors'

# server
gem 'rails', '~> 5.2.0'
gem 'loofah', '~> 2.2.2'
gem 'puma', '~> 3.7'

# assets
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'therubyracer'
gem 'uglifier'
gem 'sass'
gem 'sass-rails'

# db
gem 'mysql2', '>= 0.3.18', '< 0.5'

group :tools do
  gem 'squasher'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
