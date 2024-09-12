class Api::V1::UserEventsController < ApplicationController
  def show
    user_event = UserEvent.find(params[:id])
    render json: UserEventSerializer.new(user_event)
  end
end