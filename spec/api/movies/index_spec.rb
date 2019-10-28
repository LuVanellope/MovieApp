require './app'
require './models/movie'

RSpec.describe MovieApp::API do
  describe "GET /movies" do
    context "No show_day provided" do
      it "should return 400" do
        get '/api/movies'

        expect(last_response.status).to eq(400)
      end
    end

    context "show_day provided" do

      let!(:movie_1) do
        Movie.create(name: 'Maleficent', description: 'Cool movie', url_image: 'https://image.com/image.jpg', begin_date: '2019-10-10', finish_date: '2019-10-20')
      end
      let!(:movie_2) do
        Movie.create(name: 'Legally Blond', description: 'Chiguagua', url_image: 'https://image.com/image.jpg', begin_date: '2019-11-10', finish_date: '2019-12-20')
      end

      let!(:movie_3) do
        Movie.create(name: 'Locos Adams', description: 'Locos Admas what a Family', url_image: 'https://image.com/image.jpg', begin_date: '2019-11-10', finish_date: '2019-12-20')
      end

      context "There are movies for the day provided" do
        it "should return 200 with an array of movies" do
          get '/api/movies', show_day: '2019-11-15'

          expect(last_response).to be_ok
          expect(json_response.count).to eq(2)
          expect(json_response).to match_array([
            a_hash_including( 
              "id"=>movie_2.id,
              "name"=>movie_2.name,
              "description"=>"Chiguagua",
              "url_image"=>"https://image.com/image.jpg"
            ),
            a_hash_including( 
              "id"=>movie_3.id,
              "name"=>movie_3.name,
              "description"=>"Locos Admas what a Family",
              "url_image"=>"https://image.com/image.jpg"
            )
          ])
        end
      end

      context "There are no movies for the day provided" do
        it "should return 200 with an array of movies" do
          get '/api/movies', show_day: '2020-02-03'

          expect(last_response).to be_ok
          expect(json_response.count).to eq(0)
        end
      end
    end
  end
end
