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

  
  it "creates a new user_event" do
    user_id = @user2.id
    event_id = @event1.id
    host = false

    post "/api/v1/user_events", params: { user_event: { user_id: user_id, event_id: event_id, host: host } }
# require 'pry'; binding.pry
    user_event = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(user_event).to be_a(Hash)
    expect(user_event).to have_key(:data)

    expect(user_event[:data][:attributes][:user_id]).to eq(user_id)
    expect(user_event[:data][:attributes][:event_id]).to eq(event_id)
    expect(user_event[:data][:attributes][:host]).to eq(host)
  end  

  it "updates an existing user_event" do
    user_event_id = @user_event1.id
    new_user_id = @user2.id
    new_event_id = @event1.id
    new_host = false

    put "/api/v1/user_events/#{user_event_id}", params: { user_event: { user_id: new_user_id, event_id: new_event_id, host: new_host } }

    user_event = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(user_event).to be_a(Hash)
    expect(user_event).to have_key(:data)

    expect(user_event[:data][:attributes][:user_id]).to eq(new_user_id)
    expect(user_event[:data][:attributes][:event_id]).to eq(new_event_id)
    expect(user_event[:data][:attributes][:host]).to eq(new_host)
  end

  it "destroys an existing user_event" do
    user_event_id = @user_event1.id

    delete "/api/v1/user_events/#{user_event_id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(UserEvent.find_by(id: user_event_id)).to be_nil
  end
end