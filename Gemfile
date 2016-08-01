source 'https://rubygems.org'
ruby '2.3.1'

gem 'jquery-rails'
gem 'nokogiri'
gem 'rails'
gem 'rspec'
gem 'rspec-rails'
gem 'activesupport', '5.0.0'
gem 'rails-controller-testing'
gem 'awesome_print'
gem 'bootstrap-sass', '~> 3.3.5.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'capybara', '~> 2.7', '>= 2.7.1'
  gem 'launchy'
  #gem 'webmock'
  #gem 'pry-rails',   '~> 0.3.2'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '2.8.0'
  gem 'chromedriver-helper'
  gem 'database_cleaner'

end

group :development do
  gem 'sqlite3'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]