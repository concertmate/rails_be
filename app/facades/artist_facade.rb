class ArtistFacade
  def self.search_artists(name)
    artists_data = ArtistService.search_artists_by_name(name)
    artists_data.map do |artist_data|
      ArtistPoro.new(artist_data)
    end
  end
end