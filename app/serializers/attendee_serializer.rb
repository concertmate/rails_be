class AttendeeSerializer
  include JSONAPI::Serializer
  
  attributes :user_id, :event_id
end