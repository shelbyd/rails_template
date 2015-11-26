def add_angular_material
  run "sed -i 's/\\/\\/= require angularjs_ujs/\\/\\/= require angular-material/' app/assets/javascripts/application.js"
  run "sed -i 's/\\/\\/= require angularjs/\\/\\/= require angular/' app/assets/javascripts/application.js"
  run "sed -i 's/ \\*= require_tree \\./ \\*= require angular-material\\n \\*= require_tree \\./' app/assets/stylesheets/application.css"
end

def create_scaffold_files
  require 'pathname'

  scaffold = Pathname.new(ENV['SCAFFOLD_DIRECTORY'])
  files = scaffold + '**/*'

  pairs = Dir[files.to_s]
    .reject { |filename| File.directory? filename }
    .each do |filename|
      desired_name = Pathname.new(filename).relative_path_from(scaffold)
      file desired_name, File.read(filename)
    end
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

create_scaffold_files

after_bundle do
  git :init
  git add: '.'
  git commit: %Q{ -m 'initial commit' }

  run 'rspec --init'
end
