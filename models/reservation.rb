require './db/load_db'

class Reservation < Sequel::Model(DB[:reservations])
  many_to_one :movie
end
