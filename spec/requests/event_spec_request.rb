require 'rails_helper'

RSpec.describe "Event" do

  describe '#creating an event' do
    it 'Creates an event' do
      event_params = {
                      event_name: "Bluegrass Week",
                      venue_name: "San Antonio Fair",
                      date_time: "2024-12-31T20:00:00Z",
                      artist: "Marty Robbins",
                      location: "San Antonio, TX"
      }

      post '/api/v1/events', params: event_params
      # require 'pry'; binding.pry
      expect(response).to be_successful
      expect(response.status).to be(201)

      event = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

      expect(event).to have_key(:venue_name)
      expect(event[:venue_name]).to eq("San Antonio Fair")
      expect(event[:venue_name]).to be_a(String)

      expect(event).to have_key(:event_name)
      expect(event[:event_name]).to eq("Bluegrass Week")
      expect(event[:event_name]).to be_a(String)

      expect(event).to have_key(:date_time)
      expect(event[:date_time]).to eq("2024-12-31T20:00:00.000Z")
      expect(event[:date_time]).to be_a(String)

      expect(event).to have_key(:artist)
      expect(event[:artist]).to eq("Marty Robbins")
      expect(event[:artist]).to be_a(String)

      expect(event).to have_key(:location)
      expect(event[:location]).to eq("San Antonio, TX")
      expect(event[:location]).to be_a(String)

    end

    it 'sad path' do 
      event_params = {
                      event_name: "Bluegrass Week",
                      venue_name: "San Antonio Fair",
                      date_time: "2024-12-31T20:00:00Z",
                      location: "San Antonio, TX"
      }

      post '/api/v1/events', params: event_params
      # require 'pry'; binding.pry
      expect(response).to_not be_successful
      expect(response.status).to be(422)
      
      event = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(event).to have_key(:errors)
      expect(event[:errors][:artist].first).to eq("can't be blank")

    end
  end
end