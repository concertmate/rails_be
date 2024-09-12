class Api::V1::UserEventsController < ApplicationController
  # this controller will handle creating an event associated with a user
  # deleting an event associated with a user
  # showing an event associated with a user
  # showing all events associated with a user
  def create 
    user = User.find(params[:user_id])
    event = user.events.create(event_params)

    if event.save
      render json: EventSerializer.new(event), status: :created
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    user = User.find(params[:user_id])
    events = user.events
    render json: EventSerializer.new(events), status: :ok
  end

  def show
    user = User.find(params[:user_id])
    event = user.events.find(params[:id])
    render json: EventSerializer.new(event), status: :ok
  end

  private
  params.require(:event).permit(:venue_name, :event_name, :date_time, :artist, :location, :user_id)
end