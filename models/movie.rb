require './db/load_db'

class Movie < Sequel::Model(DB[:movies])

  def self.movies_on_screen(show_day)
    self
      .where(Sequel.lit('(begin_date <= ?) AND (finish_date >= ?)', show_day, show_day))
  end

  def self.specific_movie(reservation_date, name)
    self
      .where(Sequel.lit('(begin_date <= ?) AND (finish_date >= ?) AND (name = ?)', reservation_date, reservation_date, name))
      .last
  end
end
