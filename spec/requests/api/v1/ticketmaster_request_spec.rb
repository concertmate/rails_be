require 'rails_helper'

RSpec.describe "Api::V1::Ticketmasters", type: :request do
  before(:each) do
    base_url = "https://app.ticketmaster.com/discovery/v2/"

    json_response_drake = File.read('spec/fixtures/drake_events.json')
    api_key = ENV['TICKETMASTER_API_KEY']
    artist = "Drake"

    stub_request(:get, "#{base_url}events.json?apikey=#{api_key}&keyword=#{artist}")
      .to_return(status: 200, body: json_response_drake, headers: { 'Content-Type' => 'application/json' })
  end

  describe '#concert' do
    it 'sends the top concerts for a given artist' do
      get '/api/v1/concerts', params: { artist: 'Drake' }

      ticket_m_details = JSON.parse(response.body, symbolize_names: true)
      
      # require 'pry'; binding.pry 
      expect(response).to be_successful
      expect(ticket_m_details).to be_a(Hash)
      expect(ticket_m_details[:data][:attributes][:concert_name]).to eq("DRAKE")
      expect(ticket_m_details[:data][:attributes][:concert_date]).to eq("2024-10-01")
    end
  end
end