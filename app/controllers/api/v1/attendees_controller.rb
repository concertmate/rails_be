class Api::V1::AttendeesController < ApplicationController
  def create
    event = Event.find(attendee_params[:event_id])
    attendee = event.attendees.new(attendee_params)
    if attendee.save
      render json: AttendeeSerializer.new(attendee), status: :created
    else
      render json: { errors: attendee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    attendee = Attendee.find_by(id: params[:id])

    if attendee
      attendee.destroy
      render json: { message: 'Attendee removed successfully' }, status: :ok
    else
      render json: { errors: 'Attendee not found' }, status: :not_found
    end
  end

  def index
    attendees = Attendee.all
    render json: AttendeeSerializer.new(attendees), status: :ok
  end
  ##### NEED TO SQUARE AWAY JSON RENDERING WITH SERIALIZERS FOR ALL ACTIONS #####
  private

  def attendee_params
    params.require(:attendee).permit(:user_id, :event_id)
  end
end