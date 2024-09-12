class Api::V1::ArtistsController < ApplicationController
  def index
    if params[:name]
      begin
        artists = ArtistFacade.search_artists(params[:name])
        render json: ArtistSerializer.new(artists)
      rescue JSON::ParserError => e
        render json: { errors: [{ detail: "Failed to parse response: #{e.message}" }] }, status: :internal_server_error
      rescue StandardError => e
        render json: ErrorSerializer.new(e).serialize_json, status: :internal_server_error
      end
    else
      error = ErrorSerializer.new(StandardError.new('Name parameter is required'))
      render json: error.serialize_json, status: :bad_request
    end
  end

  def create
    user = User.find(params[:user_id])
    artist = Artist.find_or_create_by!(artist_params)
    
    UserArtist.find_or_create_by!(user: user, artist: artist)
    
    render json: artist, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: ErrorSerializer.new(e).serialize_json, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: ErrorSerializer.new(e).serialize_json, status: :bad_request
  end

  def destroy
    user_artist = UserArtist.find_by!(user_id: params[:user_id], artist_id: params[:id])
    user_artist.destroy
    
    render json: { message: "Artist removed from user's saved artists" }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: ErrorSerializer.new(e).serialize_json, status: :not_found
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :musicbrainz_id)
  end
end