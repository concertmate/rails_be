require 'rails_helper'

RSpec.describe 'User API', type: :request do

  before :each do 
    @user1 = User.create(name: 'John Doe', email: 'john@email.com')
    @user2 = User.create(name: 'Jane Doe', email: 'jane@email.com')
  end

  it "sends a user by it's id" do
    user_id = @user1.id

    get "/api/v1/users/#{user_id}"

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)
  end
end