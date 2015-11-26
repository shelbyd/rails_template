def with_file(filename)
  @filename = filename

  def sed_sub(string)
    [
      '*',
      '.',
      '/',
    ].reduce(string) { |string, replace| string.gsub(replace, '\\' + replace) }
  end

  def replace(source, target)
    run "sed -i 's/#{sed_sub(source)}/#{sed_sub(target)}/' #{@filename}"
  end

  def add_before(location, to_add)
    to_add = to_add.join('\\n') if to_add.is_a? Array
    replace location, "#{to_add}\\n#{location}"
  end

  def add_after(location, to_add)
    to_add = to_add.join('\\n') if to_add.is_a? Array
    replace location, "#{location}\\n#{to_add}"
  end

  yield
end

def add_angular_material
  with_file 'app/assets/stylesheets/application.css' do
    add_before ' *= require_tree .', ' *= require angular-material'
  end
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

def install_devise
  gem 'devise'

  generate 'devise:install'
  generate :devise, 'User'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
end

gem 'slim-rails'

gem 'passenger'

add_source 'http://rails-assets.org'

gem 'rails-assets-angular-material'

add_angular_material

with_file 'config/database.yml' do
  add_after '  encoding: unicode', [
    '  username: development_user',
    '  password: development_password',
  ]
end

[
  'README.rdoc',
  'app/views/layouts/application.html.erb',
].each { |filename| run "rm #{filename}" }

install_devise

rake 'db:drop'
rake 'db:create'
rake 'db:migrate'

route "root to: 'pages#home'"

after_bundle do
  run 'rspec --init'

  create_scaffold_files

  git :init
  git add: '.'
  git commit: %Q{ -m 'initial commit' }
end
