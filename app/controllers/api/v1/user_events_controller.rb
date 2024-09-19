class Api::V1::UserEventsController < ApplicationController
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

    def destroy
      user = User.find(params[:user_id])
      event = user.events.find(params[:id])
      if event.destroy
        render json: { message: "Event deleted successfully" }, status: :ok
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    end

  private
  def event_params
    params.require(:event).permit(:venue_name, :event_name, :date_time, :artist, :location, :user_id)
  end
end