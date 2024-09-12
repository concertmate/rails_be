class ArtistController < ApplicationController
  def index
    artists = ArtistFacade.all_artists
    render json: ArtistSerializer.new(artists)
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