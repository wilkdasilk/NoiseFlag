class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def show

  end

  private

  def set_user
    user_id = params[:id]
    @user = User.find_by_id(user_id)
  end
end
