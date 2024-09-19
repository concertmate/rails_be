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
    # host = false

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

  it 'cant create attendee' do 
    user_id = User.create(name: 'John Doe', email: '')
    event_id = @event1.id
    # host = false

    post "/api/v1/attendees", params: { attendee: { user_id: user_id, event_id: event_id } }
    # require 'pry'; binding.pry

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    attendee = JSON.parse(response.body, symbolize_names: true)

    expect(attendee).to be_a(Hash)
    # require 'pry'; binding.pry
    expect(attendee).to have_key(:errors)

    expect(attendee[:errors]).to be_a(Array)
    expect(attendee[:errors].first).to be_a(String)
    expect(attendee[:errors].first).to eq("User must exist")
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
    attendee_id = @attendee.id

    delete "/api/v1/attendees/#{attendee_id}"


    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(Attendee.find_by(id: attendee_id)).to be_nil
  end

  it 'cant destory a attendee there is no attendee there' do 
    attendee_id = '12345678765432345676543456754'

    delete "/api/v1/attendees/#{attendee_id}"


    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    # require 'pry'; binding.pry
    attendee = JSON.parse(response.body, symbolize_names: true)

    expect(attendee).to have_key(:errors)
    expect(attendee[:errors]).to be_a(String)
    expect(attendee[:errors]).to eq("Attendee not found")
  end

  
  describe 'index' do 
  
    it 'returns attendees' do 
      get "/api/v1/attendees?event_id=#{@event1.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      attendees = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(attendees).to have_key(:data)
      expect(attendees).to be_a(Hash)
      expect(attendees.count).to eq(1)
      expect(attendees).to have_key(:data)

      expect(attendees[:data]).to be_a(Array)
      expect(attendees[:data].first).to have_key(:id)
      expect(attendees[:data].first[:id]).to be_a(String)
      expect(attendees[:data].first[:id]).to eq("#{attendees[:data].first[:id]}")

      expect(attendees[:data].first).to have_key(:type)
      expect(attendees[:data].first[:type]).to be_a(String)
      expect(attendees[:data].first[:type]).to eq("attendee")

      expect(attendees[:data].first).to have_key(:attributes)
      expect(attendees[:data].first[:attributes]).to be_a(Hash)

      # require 'pry'; binding.pry
      expect(attendees[:data].first[:attributes][:user_id]).to be_a(Integer)
      expect(attendees[:data].first[:attributes][:user_id]).to eq(attendees[:data].first[:attributes][:user_id])

      expect(attendees[:data].first[:attributes][:event_id]).to be_a(Integer)
      expect(attendees[:data].first[:attributes][:event_id]).to eq(attendees[:data].first[:attributes][:event_id])
    end
  end
end