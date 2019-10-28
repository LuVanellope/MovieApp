require 'grape'
require './models/movie'

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
        movies = Movie.where(Sequel.lit('(begin_date <= ?) AND (finish_date >= ?)', params[:show_day], params[:show_day]))
        JSON.parse(movies.to_json)
      end
    end
  end
end

