class ArtistService
  def self.get_conn
    Faraday.new(url: 'https://musicbrainz.org/ws/2') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.get_all_artists
    response = get_conn.get('/artist', { query: 'artist:*' }, fmt: 'json')
    JSON.parse(response.body, symbolize_names: true)
  end
end