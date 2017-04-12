class CheckinsController < ApplicationController

  before_action :set_flag_by_id
  before_action :require_login

  def new

  end

  def create
    if user_nearby?(@flag)
      current_user.checkins.active[0].inactive! if current_user.checkins.active.length >0
      @checkin = current_user.checkins.create
      @flag.checkins << @checkin
      respond_to do |format|
       if @checkin.save
         format.html { redirect_to @flag, notice: "Checked in successfully!" }
       end
      end
    else
      respond_to do |format|
        format.html { redirect_to @flag, notice: "Could not check in" }
      end
   end

 end

end
