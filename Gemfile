source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

# Core
gem "rails", "~> 7.0.4" # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "propshaft" # The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "pg", "~> 1.1" # Use postgresql as the database for Active Record
gem "puma", "~> 5.0" # Use the Puma web server [https://github.com/puma/puma]
gem "jsbundling-rails" # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "turbo-rails" # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "stimulus-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "cssbundling-rails" # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "jbuilder" # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "redis", "~> 4.0" # Use Redis adapter to run Action Cable in production
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb

# Styling
gem "inline_svg"
gem "pagy", "~> 6.0"

# Analytics
gem "ahoy_matey", "~>4.2"

# SEO
gem "meta-tags", "~> 2.18"
gem "canonical-rails", github: "jumph4x/canonical-rails"

# Auth
gem "devise", "~>4.9.0"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"

# Third Party API
gem "faraday-http-cache"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "awesome_print" # https://github.com/awesome-print/awesome_print
  gem "brakeman"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry", "~> 0.13.1"
  gem "pry-byebug" # https://github.com/deivid-rodriguez/pry-byebug
  gem "pry-rails" # https://github.com/pry/pry-rails
  gem "rspec-rails"
  gem "table_print" # https://github.com/arches/table_print
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "letter_opener"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "capybara-screenshot"
  gem "selenium-webdriver"
  gem "webdrivers"
end
