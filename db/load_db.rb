require 'sequel'
require 'yaml'


url = ENV["DATABASE_URL"] || -> do
  env = ENV["RACK_ENV"] || "development"
  config = YAML.load_file('./config/database.yml')
  config.fetch(env)
end.()

DB = Sequel.connect(url)
Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :json_serializer
