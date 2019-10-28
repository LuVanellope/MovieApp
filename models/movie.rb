require './db/load_db'

class Movie < Sequel::Model(DB[:movies])

end
