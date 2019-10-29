require './app'
require './models/reservation'

RSpec.describe MovieApp::API do

  let(:movie) do
    Movie.create(name: 'Maleficent', description: 'Mistress of Evil', url_image: 'https://image.com/image.jpg', begin_date: '2019-11-10', finish_date: '2019-12-10')
  end

  let(:input) do
    {
      movie_id: movie.id,
      email: 'luisafernanda@gotocine.com',
      name: 'Maleficent',
      reservation_date: Date.new(2019, 11, 12),
    }
  end

  describe "POST /movies" do
    context "The params are valid" do
      it "Should create a new reservation for a movie" do
        post "/api/reservations", input
        expect(last_response.status).to eq(201)

        expect(Reservation.count).to eq(1)

        reservation = Reservation.last
        expect(json_response["id"]).to eq(reservation.id)

        expect(reservation.movie_id).to eq(movie.id)
        expect(reservation.reservation_date).to eq(input[:reservation_date])
        expect(reservation.movie.name).to eq(input[:name])
      end
    end

    context "The movie is not available that day" do
      it "Should be 400" do
        input[:reservation_date] = Date.new(2019, 10, 3)

        post "/api/reservations", input

        expect(last_response.status).to eq(400)
        expect(json_response).to eq({"errors"=>"The movie does not show today"})
      end
    end
  end
end
