require 'rails_helper'

RSpec.describe 'UserEvents API', type: :request do
  
  before :each do 
    @user1 = User.create(name: 'John Doe', email: 'john@email.com')
    @user2 = User.create(name: 'Jane Doe', email: 'jane@email.com')

    @event1 = Event.create(venue_name: 'The Fillmore', date_time: '2021-09-01T20:00:00.000Z', artist: 'The Beatles', location: 'San Francisco')

    @user_event1 = UserEvent.create(user_id: @user1.id, event_id: @event1.id, host: true)
  end

  it "sends a user_event by its id" do
    user_event_id = @user_event1.id

    get "/api/v1/user_events/#{user_event_id}"

    user_event = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(user_event).to be_a(Hash)
    expect(user_event).to have_key(:data)

    expect(user_event[:data][:attributes][:user_id]).to eq(@user1.id)
    expect(user_event[:data][:attributes][:event_id]).to eq(@event1.id)
    expect(user_event[:data][:attributes][:host]).to eq(true)
  end
end