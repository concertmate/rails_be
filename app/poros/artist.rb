class Artist
  attr_reader :name, :musicbrainz_id

  def initialize(data)
    @name = data[:name]
    @musicbrainz_id = data[:musicbrainz_id]
  end
end