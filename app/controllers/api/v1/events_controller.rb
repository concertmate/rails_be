class Api::V1::EventsController < ApplicationController
  # THIS CONTROLLER NOW RENDERS JSON FOR ALL DB EVENTS, WE DO NOT NEED A CREATE AND DESTROY ACTION FOR EVENTS IN THIS CONTROLLER
  # THAT WILL HAPPEN IN USER_EVENTS CONTROLLER
  # WE JUST NEED INDEX ACTION TO SHOW ALL EVENTS EVENT.ALL
  # AND SHOW ACTION TO SHOW A SINGLE EVENT EVENT.FIND(BY ID)

  def index
    events = Event.all
    render json: EventSerializer.new(events)
  end

  def show
    event = Event.find(params[:id])
    render json: EventSerializer.new(event)
  end
end