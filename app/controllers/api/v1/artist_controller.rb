class ArtistController < ApplicationController
  def index
    if params[:name]
      artists = ArtistFacade.search_artists(params[:name])
      render json: ArtistSerializer.new(artists)
    else
      error = ErrorSerializer.new(StandardError.new('Name parameter is required'))
      render json: error.serialize_json, status: :bad_request
    end
  end

  def create
    user = User.find(params[:user_id])
    artist = Artist.find_or_create_by(name: params[:name], musicbrainz_id: params[:musicbrainz_id])
    user.artists << artist unless user.artists.include?(artist)
    render json: user.artists
  end

  def destroy
    user = User.find(params[:user_id])
    artist = user.artists.find(params[:id])
    user.artists.delete(artist)
    render json: user.artists
  end
end