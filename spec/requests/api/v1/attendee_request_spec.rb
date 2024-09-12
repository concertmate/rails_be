require 'rails_helper'

RSpec.describe 'Attendees API', type: :request do
  
  before :each do 
    @user1 = User.create(name: 'John Doe', email: 'john@email.com')
    @user2 = User.create(name: 'Jane Doe', email: 'jane@email.com')

    @event1 = Event.create(venue_name: 'The Fillmore', date_time: '2021-09-01T20:00:00.000Z', artist: 'The Beatles', location: 'San Francisco')

    @attendee = Attendee.create(user_id: @user1.id, event_id: @event1.id)
  end

  # it "returns all attendee by its id" do
  #   atttendee_id = @attendee.id

  #   get "/api/v1/users/#{@user1.id}/attendees/#{atttendee_id}"

  #   attendee = JSON.parse(response.body, symbolize_names: true)

  #   expect(response).to be_successful
  #   expect(response.status).to eq(200)

  #   expect(attendee).to be_a(Hash)
  #   expect(attendee).to have_key(:data)

  #   expect(attendee[:data][:attributes][:user_id]).to eq(@user1.id)
  #   expect(attendee[:data][:attributes][:event_id]).to eq(@event1.id)
  # end
  
  it "creates a new attendee" do
    user_id = @user2.id
    event_id = @event1.id
    host = false

    post "/api/v1/attendees", params: { attendee: { user_id: user_id, event_id: event_id } }
# require 'pry'; binding.pry
    attendee = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(attendee).to be_a(Hash)
    # require 'pry'; binding.pry
    expect(attendee).to have_key(:data)

    expect(attendee[:data][:attributes][:user_id]).to eq(user_id)
    expect(attendee[:data][:attributes][:event_id]).to eq(event_id)

  end  

  # it "updates an existing attendee" do
  #   atttendee_id = @attendee.id
  #   new_user_id = @user2.id
  #   new_event_id = @event1.id

  #   put "/api/v1/attendees/#{atttendee_id}", params: { attendee: { user_id: new_user_id, event_id: new_event_id } }

  #   attendee = JSON.parse(response.body, symbolize_names: true)

  #   expect(response).to be_successful
  #   expect(response.status).to eq(200)

  #   expect(attendee).to be_a(Hash)
  #   expect(attendee).to have_key(:data)

  #   expect(attendee[:data][:attributes][:user_id]).to eq(new_user_id)
  #   expect(attendee[:data][:attributes][:event_id]).to eq(new_event_id)
  # end

  it "destroys an existing attendee" do
    atttendee_id = @attendee.id


    delete "/api/v1/attendees/#{atttendee_id}"
    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(Attendee.find_by(id: atttendee_id)).to be_nil
  end
end