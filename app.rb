require 'grape'

module MovieApp
  class API < Grape::API
    format :json
    prefix :api
    
    resource :movies do
      get '/' do
        { Hello: 'Jose' }
      end
    end    
  end
end

