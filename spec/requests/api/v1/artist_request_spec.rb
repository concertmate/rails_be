require "rails_helper"

RSpec.describe "Api::V1::Artists", type: :request do
  describe "GET /api/v1/artists" do
    it "returns a list of artist matching search" do
      artist_json = File.read('spec/fixtures/artist_search.json')

      stub_request(:get, "https://musicbrainz.org/ws/2/artist")
        .with(query: { query: "Green", fmt: "json", limit: 10 })
          .to_return(status: 200, body: artist_json, headers: { 'Content-Type' => 'application/json' })

      get "/api/v1/artists", params: { name: "Green" }

      expect(response).to have_http_status(200)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)
      expect(data[:data]).to be_an(Array)
      expect(data[:data].count).to eq(25)
    end
  end
end