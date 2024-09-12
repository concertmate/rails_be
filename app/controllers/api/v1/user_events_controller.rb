class Api::V1::UserEventsController < ApplicationController
  def show
    user_event = UserEvent.find(params[:id])
    render json: UserEventSerializer.new(user_event)
  end

  def create
    user_event = UserEvent.new(user_event_params)
    if user_event.save
      render json: UserEventSerializer.new(user_event), status: :created
    else
      render json: { errors: user_event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user_event = UserEvent.find(params[:id])

    if user_event.destroy
      render json: { message: "UserEvent has been deleted" }, status: :no_content
    else
      render json: { errors: user_event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user_event = UserEvent.find(params[:id])
    
    if user_event.update(user_event_params)
      render json: UserEventSerializer.new(user_event), status: :ok
    else
      render json: { errors: user_event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_event_params
    params.require(:user_event).permit(:user_id, :event_id, :host)
  end
end