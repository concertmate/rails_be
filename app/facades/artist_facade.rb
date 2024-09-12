class ArtistFacade
  def self.search_artists(name)
    artists_data = ArtistService.get_artists_by_name(name)
    artists_data.map do |artist_data|
      condensed_data = {
        name: artist_data[:name],
        id: artist_data[:id]
      }
      Artist.new(condensed_data)
    end
  end
end