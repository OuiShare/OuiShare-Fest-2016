source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'nokogiri'

gem 'pg', '0.17.0'

#JS Runtimes to enable JS compatibility on Unix Server
gem 'therubyracer', :platforms => :ruby
gem 'execjs', :platforms => :ruby

# HAML
gem 'haml', '4.0.3'
gem 'html2haml'
gem 'haml-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Email sending
gem 'mailboxer', '0.10.3'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Attachments
gem 'paperclip'
gem 'aws-sdk'

# Front-end
gem 'jquery-rails'

# Keep bots from submitting forms
gem 'negative_captcha'

# gem 'bootstrap-sass', '~> 2.3.1.0'
#gem 'bootstrap-sass', :git => 'git://github.com/thomas-mcdonald/bootstrap-sass.git', :branch => '3'
gem 'bootstrap-sass', '~> 3.0.3.0'

# Rails Environment Variables
gem 'figaro'

# Authentication
# gem 'bcrypt-ruby', '3.0.1', :require => 'bcrypt'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook' #, "1.4.0"
gem 'oauth2'
gem 'fb_graph'
gem 'omniauth-linkedin-oauth2', :git => 'https://github.com/amine-bouassida/omniauth-linkedin-oauth2.git'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem "omniauth-google-oauth2"

# Twitter Button
gem "tweet-button"

#Localisation gem
gem 'rails-i18n', '~> 3.0.0.pre'

#Missing traduction checking
gem 'i18n-tasks', '~> 0.1.0'

#Manageable Traductions
gem 'i18n-active_record',
    :git => 'git://github.com/svenfuchs/i18n-active_record.git',
    :require => 'i18n/active_record'

group :development, :test do
  gem "better_errors"
  gem "rspec-rails"
  gem 'factory_girl_rails'
  #provide more helpers to rspec
  gem 'webrat'

  #provide access to manipulate variable in error console
  gem 'binding_of_caller'

end

platforms :ruby do
  group :development, :test do
    gem 'railroady'
  end
end

# Installation gem google analytics
gem 'google-analytics-rails'

#google Map gem
gem 'gmaps4rails', '1.5.6'

#Geolocalisation IP
gem 'geoip'

#Gem pour securiser les params
gem 'strong_parameters'

#Gem API with eventbrite
gem 'eventbrite-client'