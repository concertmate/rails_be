require "rails_helper"

RSpec.describe TicketMasterService do
  describe "get_events" do
    it "returns a list of events" do
      base_url = "https://app.ticketmaster.com/discovery/v2/events.json"

      json_response_drake = File.read("spec/fixtures/drake_events.json")
      
      api_key = ENV['TICKETMASTER_API_KEY']
      artist = "Drake"

      stub_request(:get, "#{base_url}?keyword=#{artist}&apikey=#{api_key}")
        .to_return(status: 200, body: json_response_drake, headers: { 'Content-Type' => 'application/json' })

      events = TicketMasterService.get_events(artist)

      expect(events).to be_a(Hash)
      expect(events).to have_key(:_embedded)
      expect(events[:_embedded]).to be_a(Hash)
      expect(events[:_embedded]).to have_key(:events)
      expect(events[:_embedded][:events]).to be_a(Array)
    end
  end
end