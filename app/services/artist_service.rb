class ArtistService
  def self.get_conn
    Faraday.new(url: 'https://musicbrainz.org/ws/2') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.get_artist_by_name(name)
    response = get_conn.get('/artist', { query: "artist:#{name}", fmt: 'json' })
    JSON.parse(response.body, symbolize_names: true)[:artists]
  end
end