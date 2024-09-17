class ConcertSerializer
  include JSONAPI::Serializer

  attributes :concert_name, 
              :concert_date, 
              :concert_time, 
              :concert_venue, 
              :concert_country
end