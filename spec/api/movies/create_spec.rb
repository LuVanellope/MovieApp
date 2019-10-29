require './app'

RSpec.describe MovieApp::API do
  let(:input) do
    {
      name: 'Maleficent: Mistress of Evil',
      description: "Maleficent travels to a grand old castle to celebrate young Aurora's upcoming wedding to Prince Phillip.",
      url_image: 'https://tumbrl.com/Maleficent',
      begin_date: '2019-10-10',
      finish_date: '2019-11-10'
    }
  end


  describe "POST /movies" do
    context "The params are valid" do

      it "Should create a new movie" do
        post '/api/movies', input

        expect(last_response.status).to eq(201)

        expect(Movie.count).to eq(1)

        movie = Movie.last
        expect(json_response["id"]).to eq(movie.id)

        expect(movie.name).to eq(input[:name])
        expect(movie.description).to eq(input[:description])
        expect(movie.url_image).to eq(input[:url_image])
        expect(movie.begin_date).to eq(DateTime.new(2019,10,10))
        expect(movie.finish_date).to eq(DateTime.new(2019,11,10))
      end
    end

    context "The params are not valid" do
      it "Should create a new movie" do
        post '/api/movies', {}

        expect(last_response).not_to be_ok
        expect(last_response.status).to eq(400)

        expect(Movie.count).to eq(0)
        expect(json_response).to eq(
          "errors" => {
            "name"=>"is missing",
            "description"=>"is missing",
            "url_image"=>"is missing",
            "begin_date"=>"is missing",
            "finish_date"=>"is missing",
          }
        )
      end
    end
  end
end
