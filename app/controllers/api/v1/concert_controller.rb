class Api::V1::ConcertController < ApplicationController
  def show
    artist = params[:artist]
    begin
      top_concert = ConcertFacade.new.get_top_concert(artist)
      render json: ConcertSerializer.new(top_concert)
    rescue => e
      logger.error "Error fetching concert: #{e.message}"
      render json: { error: 'No concerts found' }, status: :not_found
    end
  end
end