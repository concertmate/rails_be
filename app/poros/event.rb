class Event
  attr_reader :venue_name, :date, :time, :artist_name

  def initialize(event_data)
    @venue_name = event_data[:_embedded][:venues][0][:name]
    @date = event_data[:dates][:start][:localDate]
    @time = event_data[:dates][:start][:localTime]
    @artist_name = event_data[:name]
  end
end