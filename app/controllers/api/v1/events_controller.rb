class Api::V1::EventsController < ApplicationController 
  def create
    event = Event.new(event_params)

    if event.save 
      render json: EventSerializer.new(event), status: :created
    else 
      render json: { errors: event.errors }, status: :unprocessable_entity
    end
  end

  def destroy 
    event = Event.find(params[:id])
    event.destroy
  end

  private 

  def event_params
    params.permit(:venue_name, :event_name, :date_time, :artist, :location)
  end
end