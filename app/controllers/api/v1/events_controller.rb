class Api::V1::EventsController < ApplicationController
  def index
    events = Event.all
    render json: EventSerializer.new(events)
  end

  def show
    event = Event.find(params[:id])
    render json: EventSerializer.new(event)
  end
end