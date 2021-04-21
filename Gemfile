source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap-sass', '3.4.1'
gem 'carrierwave', '~> 2.0'
gem 'devise'
gem 'devise-async'
gem 'figaro'
gem 'file_validators'
gem 'fog-aws'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'mini_magick'
gem 'omniauth-oktaoauth'
gem 'omniauth-rails_csrf_protection', '~> 0.1'
gem 'paranoia'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'ransack'
gem 'rubocop-rails', require: false
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'sidekiq-cron', '~> 1.1'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'mysql2', '>= 0.4.4'
  gem 'rspec-rails', '~> 4.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

group :production do
  gem 'pg', '1.2.3'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
