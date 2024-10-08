require "rails_helper"

RSpec.describe "Api::V1::Artists", type: :request do
  describe "GET /api/v1/artists" do
    it "returns a list of artist matching search" do
      VCR.turned_off do
        artist_json = File.read('spec/fixtures/artist_search.json')

        stub_request(:get, "https://musicbrainz.org/artist?fmt=json&query=artist:Green").
          with(
              headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type'=>'application/json',
                'User-Agent'=>'Faraday v2.11.0'
                }).
          to_return(status: 200, body: artist_json, headers: { 'Content-Type' => 'application/json' })

        get "/api/v1/artists", params: { name: "Green" }

        expect(response).to have_http_status(200)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_a(Hash)
        expect(data).to have_key(:data)
        expect(data[:data]).to be_an(Array)
        expect(data[:data].count).to eq(10)

        expect(data[:data].first).to have_key(:type)
        expect(data[:data].first).to have_key(:attributes)

        expect(data[:data].first[:attributes]).to have_key(:name)
        expect(data[:data].first[:attributes][:name]).to be_a(String)
        expect(data[:data].first[:attributes][:name]).to eq("Green Day")

        expect(data[:data].first[:attributes]).to have_key(:musicbrainz_id)
        expect(data[:data].first[:attributes][:musicbrainz_id]).to eq(nil)

      end
    end

    it "returns an error if no search name is passed" do
      VCR.turned_off do
        get "/api/v1/artists"

        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(data).to be_an(Array)
        expect(data.first).to have_key(:detail)
        expect(data.first[:detail]).to be_a(String)
        expect(data.first[:detail]).to eq("Name parameter is required")
      end
    end
  end

  describe "POST /api/v1/artists" do

    let(:user) { create(:user) }
    let(:artist_params) { { artist: { name: "Green Day", musicbrainz_id: "id" }, user_id: user.id } }

    it "adds an artist to a user's artists" do
      post "/api/v1/artists", params: artist_params

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_an(Hash)

      expect(data).to have_key(:name)
      expect(data[:name]).to be_a(String)
      expect(data[:name]).to eq("Green Day")

      expect(data).to have_key(:musicbrainz_id)
      expect(data[:musicbrainz_id]).to be_a(String)
      expect(data[:musicbrainz_id]).to eq("id")
    end

    it "returns an error if required parameters are missing" do
      post "/api/v1/artists", params: { artist: { name: nil, musicbrainz_id: nil }, user_id: user.id }

      expect(response).to have_http_status(:bad_request)
      data = JSON.parse(response.body, symbolize_names: true)[:errors]
      expect(data).to be_an(Array)

      expect(data.first[:detail]).to be_a(String)
      expect(data.first[:detail]).to eq("Validation failed: Name can't be blank, Musicbrainz can't be blank")
    end

    it "returns an error if the user does not exist" do
      post "/api/v1/artists", params: { artist: { name: "Green Day", musicbrainz_id: "id" }, user_id: -1 }

      expect(response).to have_http_status(:not_found)
      data = JSON.parse(response.body, symbolize_names: true)[:errors]
      expect(data).to be_an(Array)
      expect(data.first[:detail]).to be_a(String)
      expect(data.first[:detail]).to eq("Couldn't find User with 'id'=-1")
    end
  end

  describe "DELETE /api/v1/artists/:id" do
    let(:user) { create(:user) }
    let(:artist) { create(:artist) }
    let!(:user_artist) { create(:user_artist, user: user, artist: artist) }  # Create the association

    it "deletes an artist from a user's saved artists" do
      delete "/api/v1/artists/#{artist.id}", params: { user_id: user.id }

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:message]).to be_a(String)
      expect(data[:message]).to eq("Artist removed from user's saved artists")
    end

    it "returns an error if the user does not exist" do
      delete "/api/v1/artists/#{artist.id}", params: { user_id: -1 }

      expect(response).to have_http_status(:not_found)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:detail]).to be_a(String)
      expect(data[:errors].first[:detail]).to eq("Couldn't find UserArtist with [WHERE \"user_artists\".\"user_id\" = $1 AND \"user_artists\".\"artist_id\" = $2]")
    end
  end

  it 'parse error' do 
    allow(ArtistFacade).to receive(:search_artists).and_raise(JSON::ParserError.new('unexpected token'))
    #^ this is basically mocking the search artist from the facade  and then we raise the JSON::ParserError then just simulate where the json response fails at.
    get "/api/v1/artists", params: { name: 'invalid_artist' }

    expect(response).to_not be_successful 
    expect(response.status).to eq(500) 

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_an(Array)
    expect(data[:errors].first[:detail]).to be_a(String)
    expect(data[:errors].first[:detail]).to eq("Failed to parse response: unexpected token")
  end

  it 'standard error' do 
    allow(ArtistFacade).to receive(:search_artists).and_raise(StandardError.new('something went wrong'))

    get "/api/v1/artists", params: { name: 'artist_with_error' }
  
    expect(response).to_not be_successful
    # require 'pry'; binding.pry
    expect(response.status).to eq(500)
    data = JSON.parse(response.body, symbolize_names: true)
  
    expect(data[:errors]).to be_an(Array)
    expect(data[:errors].first).to have_key(:detail)
    expect(data[:errors].first[:detail]).to be_a(String)
    expect(data[:errors].first[:detail]).to eq('something went wrong')
  end
end