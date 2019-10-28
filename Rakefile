namespace :db do

  task :create do
    require 'sequel'
    require 'yaml'

    url = ENV["DATABASE_URL"] || -> do
      env = ENV["RACK_ENV"] || "development"
      config = YAML.load_file('./config/database.yml')
      config.fetch(env)
    end.()

    db_name = url.match(/\/([^\/]+)$/)[1]

    Sequel.connect('postgres://postgres@database:5432/postgres') do |db|
      db.execute "DROP DATABASE IF EXISTS #{db_name} "
      db.execute "CREATE DATABASE #{db_name} "
    end
  end

  task :migrate, [:version, :env]  do  |t, args|
    
    require 'sequel'
    require 'yaml'

    url = ENV["DATABASE_URL"] || -> do
      env = ENV["RACK_ENV"] || "development"
      config = YAML.load_file('./config/database.yml')
      config.fetch(env)
    end.()

    Sequel.extension :migration
    version = args[:version].to_i if args[:version]

    Sequel.connect(url) do |db|
      Sequel::Migrator.run(db, "db/migrate", target: version)
    end
  end

  task :test_prepare do
    system("RACK_ENV=test rake db:create")
    system("RACK_ENV=test rake db:migrate")
  end
end
