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
      end
    end
  end
end