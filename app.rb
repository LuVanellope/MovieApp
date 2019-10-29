require 'grape'
require './models/movie'
require './models/reservation'

module MovieApp
  class API < Grape::API
    format :json
    prefix :api

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      errors = e.each_with_object({}) { |(x, y), hash| hash[x.first] = y.to_s }

       error!({"errors": errors}, 400)
    end

    resource :movies do
      params do
        requires :name, type: String
        requires :description, type: String
        requires :url_image, type: String
        requires :begin_date, type: DateTime
        requires :finish_date, type: DateTime
      end
      post '/' do
        movie = Movie.new(params)
        if movie.valid?
          movie.save
          JSON.parse(movie.to_json)
        else
        end
      end
    end

    resource :movies do
      params do
        requires :show_day, type: DateTime
      end
      get '/' do
        movies = Movie.movies_on_screen(params[:show_day])
        JSON.parse(movies.to_json)
      end
    end

    resource :reservations do
      params do
        requires :email, type: String
        requires :name, type: String
        requires :reservation_date, type: DateTime
      end
      post '/' do
        movie = Movie.specific_movie(params[:reservation_date], params[:name])
        if movie
          reservation = Reservation.new(params.slice(:reservation_date, :email).merge(movie_id: movie.id))
          reservation.save
          JSON.parse(reservation.to_json)
        else
          status 400
          {errors: 'The movie does not show today'}
        end

      end
    end
  end
end
