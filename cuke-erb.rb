rvmrc = <<-RVMRC
rvm ruby-1.9.2p0@#{app_name}
RVMRC

create_file ".rvmrc", rvmrc

gem "capybara", ">= 0.4.0", :group => [:cucumber, :test]
gem "cucumber-rails", ">= 0.3.2", :group => [:cucumber, :test]
gem "database_cleaner", ">= 0.5.2", :group => [:cucumber, :test]
gem "factory_girl_rails", ">= 1.0.0", :group => [:cucumber, :test]
gem "factory_girl_generator", ">= 0.0.1", :group => [:cucumber, :development, :test]
gem "launchy", ">= 0.3.7", :group => [:cucumber, :test]
gem "rspec-rails", ">= 2.0.1", :group => [:cucumber, :development, :test]
gem "spork", ">= 0.8.4", :group => [:cucumber, :test]

generators = <<-GENERATORS

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.integration_tool :rspec
    end
GENERATORS

application generators

get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js",  "public/javascripts/jquery.js"
get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/jquery-ui.min.js", "public/javascripts/jquery-ui.js"
`curl https://github.com/rails/jquery-ujs/raw/master/src/rails.js -o public/javascripts/rails.js`

gsub_file 'config/application.rb', 'config.action_view.javascript_expansions[:defaults] = %w()', 'config.action_view.javascript_expansions[:defaults] = %w(jquery.js jquery-ui.js rails.js)'

create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

git :init
git :add => "."

docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% rvm gemset create #{app_name}
% cd #{app_name}
% gem install bundler
% bundle install
% script/rails generate rspec:install
% script/rails generate cucumber:install --rspec --capybara

DOCS

log docs
