source "https://rubygems.org"

ruby "2.4.0"

gem "autoprefixer-rails"
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.2'
gem "flutie"
gem "honeybadger"
gem "jquery-rails"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem 'rails', '~> 5.1', '>= 5.1.4'
gem "recipient_interceptor"
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'simple_form', '~> 3.5'
gem "skylight"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "title"
gem "uglifier"

group :development do
  gem "listen"
  gem "spring"
  gem "spring-commands-rspec"
  gem 'web-console', '~> 3.5', '>= 3.5.1'
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "refills"
  gem 'rspec-rails', '~> 3.7'
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_stdout_logging"
end

gem 'high_voltage'
gem 'bourbon', '5.0.0.beta.6'
gem 'neat', '~> 1.8.0'
#customization
gem 'turbolinks', '~> 5.0'

#consume json api
gem 'faraday', '~> 0.9.2' 
gem 'faraday_middleware', '~> 0.10.0'
gem 'mechanize', '~> 2.7', '>= 2.7.4'
gem 'foursquare2', '~> 2.0', '>= 2.0.2'

#admin
gem 'remotipart', github: 'mshibuya/remotipart'
gem 'rails_admin', '~> 1.2'

# fuzzy search
gem 'fuzzy_match', '~> 2.1' # best match strings

# dynamic tagging of articles, photos 
gem 'acts-as-taggable-on', '~> 5.0'