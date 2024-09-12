class Api::V1::EventsController < ApplicationController
  # THIS CONTROLLER NOW RENDERS JSON FOR ALL DB EVENTS, WE DO NOT NEED A CREATE AND DESTROY ACTION FOR EVENTS IN THIS CONTROLLER
  # THAT WILL HAPPEN IN USER_EVENTS CONTROLLER
  # WE JUST NEED INDEX ACTION TO SHOW ALL EVENTS EVENT.ALL
  # AND SHOW ACTION TO SHOW A SINGLE EVENT EVENT.FIND(BY ID)
  # def create
  #   event = Event.new(event_params)

  #   if event.save 
  #     render json: EventSerializer.new(event), status: :created
  #   else 
  #     render json: { errors: event.errors }, status: :unprocessable_entity
  #   end
  # end


  # def destroy 
  #   event = Event.find(params[:id])
  #   event.destroy
  # end

  def index
    # if events = Event.all
    #     render json: EventSerializer.new(events)
    # else
    #   render json: ErrorSerializer.new(e).serialize_json, status: :not_found
    # end
  end

  private 

  def event_params
    params.permit(:venue_name, :event_name, :date_time, :artist, :location)
  end
end