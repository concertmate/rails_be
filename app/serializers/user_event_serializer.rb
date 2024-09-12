class UserEventSerializer
  include JSONAPI::Serializer

  attributes :user_id, :event_id, :host, :created_at, :updated_at
  
end