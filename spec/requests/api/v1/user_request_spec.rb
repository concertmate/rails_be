  require 'rails_helper'

RSpec.describe 'User API', type: :request do

  before :each do 
    @user1 = User.create(name: 'John Doe', email: 'john@email.com')
    @user2 = User.create(name: 'Jane Doe', email: 'jane@email.com')
  end

  it "sends a user by its id" do
    user_id = @user1.id

    get "/api/v1/users/#{user_id}"

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)

    expect(user[:data][:attributes][:name]).to eq(@user1.name)
    expect(user[:data][:attributes][:email]).to eq(@user1.email)
  end

  it "creates a new user" do
    user_params = {
      name: 'New User',
      email: 'new_user@email.com'
    }

    post "/api/v1/users", params: { user: user_params }

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)

    expect(user[:data][:attributes][:name]).to eq(user_params[:name])
    expect(user[:data][:attributes][:email]).to eq(user_params[:email])
  end

  it 'cant create a user' do 
    user_params = {
      name: '',
      email: 'new_user@email.com'
    }

    post "/api/v1/users", params: { user: user_params }

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    expect(user).to be_a(Hash)
    expect(user).to have_key(:errors)
    expect(user[:errors]).to be_a(Array)

    expect(user[:errors].first).to be_a(String)
    expect(user[:errors].first).to eq("Name can't be blank")
  end

  it "updates an existing user" do
    user_id = @user1.id
    updated_name = 'Updated Name'

    put "/api/v1/users/#{user_id}", params: { user: { name: updated_name } }


    user = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)

    expect(user[:data][:attributes][:name]).to eq(updated_name)
    expect(user[:data][:attributes][:email]).to eq(@user1.email)
  end

  it "destroys an existing user" do
    user_id = @user1.id

    delete "/api/v1/users/#{user_id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(User.find_by(id: user_id)).to be_nil
  end

  it "sends all users" do
    get "/api/v1/users"

    users = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(users).to be_a(Hash)
    expect(users).to have_key(:data)

    expect(users[:data].count).to eq(2)

    expect(users[:data].first[:attributes][:name]).to eq(@user1.name)
    expect(users[:data].first[:attributes][:email]).to eq(@user1.email)

    expect(users[:data].last[:attributes][:name]).to eq(@user2.name)
    expect(users[:data].last[:attributes][:email]).to eq(@user2.email)
  end


end
