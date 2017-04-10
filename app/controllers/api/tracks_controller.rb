class API::TracksController < ApplicationController

  def search
    query = params[:q]
    return @tracks = Track.all if query.nil? || query == ""
    @tracks = Track.search query, fields: [:name, :artist, :album]
    if @tracks.length > 0
      return @tracks
    else
      search_spotify(query)
      # search again now that we have tracks from spotify in the database
      @tracks= Track.search query, fields: [:name, :artist, :album]
    end

  end

  private

  def search_spotify(spotify_query)
    response = HTTParty.get("https://api.spotify.com/v1/search?type=track&q=" + spotify_query)
    return console.log(response["error"]) if !!response["error"]
    items = response["tracks"]["items"]
    items.each do |item|
      spotify_id = item["id"]
      if !Track.find_by(spotify_id: spotify_id)
          Track.create!({
          name: item["name"],
          artist: item["artists"].reduce([]){|arr, artist| arr.push artist["name"] }.join(', '),
          image_url: item["album"]["images"][1]["url"],
          album: item["album"]["name"],
          spotify_id: spotify_id
          })
      end
    end
  end

end
