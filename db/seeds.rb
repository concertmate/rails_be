# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Event.destroy_all
Attendee.destroy_all
UserArtist.destroy_all
User.destroy_all
Artist.destroy_all


User.create!(name: 'peterkim_pk1',
            email: 'peterkim.pk1@gmail.com')

User.create!(name: 'konber3',
            email: 'konber3@gmail.com')

User.create!(name: 'kylemboomer',
            email: 'kylemboomer@gmail.com')

User.create!(name: 'baileyjarvis2814',
            email: 'baileyjarvis2814@gmail.com')

User.create!(name: 'clydeautin',
            email: 'cautin24@turing.edu')

User.create!(name: 'RodrigoACG',
            email: 'rodrigochavezgarcia30@gmail.com')

User.create!(name: 'GBowman1',
            email: 'garrettbowman248@gmail.com')



