def add_angular_material
  run "sed -i 's/\\/\\/= require angularjs_ujs/\\/\\/= require angular-material/' app/assets/javascripts/application.js"
  run "sed -i 's/\\/\\/= require angularjs/\\/\\/= require angular/' app/assets/javascripts/application.js"
  run "sed -i 's/ \\*= require_tree \\./ \\*= require angular-material\\n \\*= require_tree \\./' app/assets/stylesheets/application.css"
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
end

gem 'slim-rails'

add_source 'http://rails-assets.org'

gem 'rails-assets-angular-material'

add_angular_material

run "sed -i 's/encoding: unicode/encoding: unicode\\n  username: development_user\\n  password: development_password/' config/database.yml"

run 'rm README.rdoc'

rake 'db:drop'
rake 'db:create'
rake 'db:migrate'

route "root to: 'pages#home'"

file 'app/controllers/pages_controller.rb', <<-CODE
  class PagesController < ApplicationController
  end
CODE

file 'app/views/pages/home.html.slim', <<-CODE
  h1 Home Page
CODE

after_bundle do
  git :init
  git add: '.'
  git commit: %Q{ -m 'initial commit' }

  run 'rspec --init'
end
