class EntriesController < ApplicationController
  #  before_filter :authenticate_request!
  before_action :require_login
  before_action :set_flag_by_id
  before_action :set_entry, only: [:destroy]
  before_action :require_flag_owner, only: [:destroy]
  before_action :require_checkin, only: [:new, :create]
  before_action :set_track_by_id, only: [:create]

   def new
     # already seeded from spotify
     query = params[:q]
     return @tracks = Track.all if query.nil? || query == ""
     @tracks = Track.search query, fields: [:name, :artist, :album], match: :word_start, :page => params[:page], :per_page => 10
     if @tracks.length > 0
       return @tracks
     else
       search_spotify(query)
       @tracks = Track.search query, fields: [:name, :artist, :album], match: :word_start, :page => params[:page], :per_page => 10
     end
   end

   def create
     @entry = current_user.entries.create
     @track.entries << @entry
     @flag.entries << @entry
     respond_to do |format|
      if @flag.save && @track.save
        format.html { redirect_to :back, notice: "Track entered successfully!" }
      else
        format.html { redirect_to @flag, notice: "Could not add track" }
      end
    end
   end

   def destroy
     flag_id = @entry.flag.id
     respond_to do |format|
      if Entry.destroy(@entry)
        format.html { redirect_to flag_path(flag_id), notice: "Track removed successfully!" }
      else
        format.html { redirect_to @flag, notice: "Could not remove track" }
      end
    end
   end

   private

   def set_track_by_id
     track_id = params[:track_id]
     @track = Track.find_by_id(track_id)
   end

   def require_checkin
     if current_user.active_checkin.flag != @flag
       respond_to do |format|
        format.html { redirect_to @flag, notice: "Please check in first" }
      end
     end
   end

   def require_flag_owner
     redirect_to @entry.flag unless current_user == @entry.flag.user
   end

   def set_entry
     entry_id = params[:id]
     @entry = Entry.find_by_id(entry_id)
   end

end
