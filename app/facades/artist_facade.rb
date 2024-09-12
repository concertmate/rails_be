class ArtistFacade
  def self.all_artists
    artists = ArtistService.get_all_arrtists
    artists.map do |artist|
      Artist.new(artist)
    end
  end
end