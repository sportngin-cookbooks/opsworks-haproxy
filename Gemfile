source 'https://rubygems.org'

group :development do
  gem 'chef', '~>11.10.4'
  gem 'ohai', '< 8' # Ruby >= 2 required for ohai >= 8
end
 
group :development, :test do
  gem 'berkshelf', '~>2'
  gem 'test-kitchen'
  gem 'serverspec'
  gem 'kitchen-ec2'
  gem 'foodcritic'
end
