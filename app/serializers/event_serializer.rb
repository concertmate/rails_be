class EventSerializer
  include JSONAPI::Serializer
  attributes :venue_name, :event_name, :date_time, :artist, :location
end