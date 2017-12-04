source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

gem 'rails_12factor', group: :production

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'rack-cors', '~> 1.0', '>= 1.0.1'
gem 'bcrypt'
gem 'faker'
gem 'rolify'
gem 'active_model_serializers', '~> 0.10.0'

# File upload
gem 'carrierwave', :git => 'https://github.com/carrierwaveuploader/carrierwave.git'
gem 'carrierwave-base64'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'rateyo-rails', '~> 2.1', '>= 2.1.1'
gem 'haml'                # or gem 'slim'
gem 'bootstrap', git: 'https://github.com/twbs/bootstrap-rubygem'
gem 'bootstrap_form'
gem "font-awesome-rails"
gem 'turbolinks'
gem 'jbuilder'
gem 'coffee-rails'
#for mailchimp
gem 'gibbon'
#for print pretty in console
gem 'awesome_print'
#for rest-client
gem 'rest-client', '~> 2.0.2'
gem 'mime-types'
gem 'netrc', '~> 0.11.0'
gem 'http-accept', '~> 1.7'
gem 'http-cookie', '~> 1.0', '>= 1.0.3'
#end for rest-client




ruby "2.4.1"
