source 'http://rubygems.org'

gem 'linkeddata'
gem 'sparql'
gem 'equivalent-xml'
gem 'activemodel'
gem "pry"
gem "rest-client"
# This may be a temporary dependency
gem "nokogiri"

if RUBY_PLATFORM =~ /darwin/i
  gem 'autotest-fsevent'
  gem 'autotest-growl'
end

group :development do
  gem "minitest", ">= 0"
  gem "yard", "~> 0.6.0"
  gem "bundler"
  gem "jeweler", "~> 1.6.4"
  gem "simplecov", ">= 0"
  gem 'guard-markdown'
  gem "ruby-debug19"
  gem 'guard-minitest', :git => 'git://github.com/aspiers/guard-minitest.git'
end
