class TicketMasterService

  def self.conn 
    Faraday.new(url: "https://app.ticketmaster.com/discovery/v2/") do |faraday|

    end
  end

  def self.get_events(keyword)
    api_key = Rails.application.credentials.ticket_master[:api_key]

    response = conn.get("events.json?keyword=#{keyword}&apikey=#{api_key}")

    JSON.parse(response.body, symbolize_names: true)
  end
end
