class Concert
  attr_reader :concert_name, :concert_date, :concert_time, :concert_venue, :concert_country, :id

  def initialize(data)
    @id = SecureRandom.uuid 
    @concert_name = data[:name]
    @concert_date = data[:dates][:start][:localDate]
    @concert_time = data[:dates][:start][:localTime]
    @concert_venue = data[:_embedded][:venues][0][:name]
    @concert_country = data[:_embedded][:venues][0][:country][:name]
  end
end