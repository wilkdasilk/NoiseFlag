class API::TracksController < ApplicationController

  def search
    query = params[:q]
    if !query.nil? && query != ""
      @tracks = Track.search query, fields: [:name, :artist, :album]
    else
      @tracks = Track.all
    end

  end

end
