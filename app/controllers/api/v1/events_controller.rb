class Api::V1::EventsController < ApplicationController
  # THIS CONTROLLER NOW RENDERS JSON FOR ALL DB EVENTS, WE DO NOT NEED A CREATE AND DESTROY ACTION FOR EVENTS
  # THAT WILL HAPPEN IN USER_EVENTS CONTROLLER
  def create
    event = Event.new(event_params)

    if event.save 
      render json: EventSerializer.new(event), status: :created
    else 
      render json: { errors: event.errors }, status: :unprocessable_entity
    end
  end

  def index
    begin
      if params[:user_id]
        user = User.find(params[:user_id])
        events = user.events
        render json: EventSerializer.new(events)
      else
        events = Event.all
        render json: EventSerializer.new(events)
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: ErrorSerializer.new(e).serialize_json, status: :not_found
    end
  end

  private 

  def event_params
    params.permit(:venue_name, :event_name, :date_time, :artist, :location)
  end
end