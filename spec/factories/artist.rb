FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    musicbrainz_id { SecureRandom.uuid }
  end
end