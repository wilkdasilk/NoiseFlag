class API::TracksController < ApplicationController

  def search
    query = params[:q]
    return @tracks = Track.all if query.nil? || query == ""
    @tracks = Track.search query, fields: [:name, :artist, :album], match: :word_start
    if @tracks.length > 0
      return @tracks
    else
      search_spotify(query)
      # search again now that we have tracks from spotify in the database
      @tracks= Track.search query, fields: [:name, :artist, :album], match: :word_start
    end

  end

end
