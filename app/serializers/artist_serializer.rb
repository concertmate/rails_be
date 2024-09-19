class ArtistSerializer
  include JSONAPI::Serializer
  
  attributes :name, :musicbrainz_id
end