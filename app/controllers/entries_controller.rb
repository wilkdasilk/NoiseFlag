class EntriesController < ApplicationController
  #  before_filter :authenticate_request!

   def create
     flag_id = params[:flag_id]
     @flag = Flag.find_by_id(flag_id)
     @entry = current_user.entries.create(entry_params)
     @flag.entries << @entry
     respond_to do |format|
      if @flag.save
        format.json { render entry: @entry, status: :created }
      else
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
   end

   private

   def entry_params
     params.require(:entry).permit(:track_id)
   end

end
