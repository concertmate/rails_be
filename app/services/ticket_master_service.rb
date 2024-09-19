class TicketMasterService
  def self.conn 
    Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |faraday|
    end
  end

  def self.get_events(keyword)
    api_key = ENV['TICKETMASTER_API_KEY']
    response = conn.get("events.json?keyword=#{keyword}&apikey=#{api_key}")

    JSON.parse(response.body, symbolize_names: true)
  end
end
