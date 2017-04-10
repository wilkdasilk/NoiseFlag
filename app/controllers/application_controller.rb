class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_flag_by_id
    flag_id = params[:flag_id]
    @flag = Flag.find_by_id(flag_id)
  end

  private

  def set_user_location
    if params[:lat] && params[:lon]
        current_user.update({
        latitude: params[:lat].to_f,
        longitude: params[:lon].to_f,
        last_ping_time: DateTime.now().utc
        })
      # current_user.latitude = location[0]
      # current_user.longitude = location[1]
      # current_user.last_ping_time = DateTime.now().change(:offset =>"+0000")
      # current_user.save
      checkout unless user_nearby?(current_user.active_checkin)
    end
  end

  def user_nearby?(flag)
    Flag.near([current_user.latitude, current_user.longitude], 0.5, :units => :mi).include?(flag)
  end

  def checkout
    current_user.active_checkin.inactive! if !!current_user.active_checkin
  end

  #from https://www.sitepoint.com/introduction-to-using-jwt-in-rails/
  # attr_reader :current_user
  #
  # protected
  # def authenticate_request!
  #   unless user_id_in_token?
  #     render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  #     return
  #   end
  #   @current_user = User.find(auth_token[:user_id])
  # rescue JWT::VerificationError, JWT::DecodeError
  #   render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  # end
  #
  # private
  # def http_token
  #     @http_token ||= if request.headers['Authorization'].present?
  #       request.headers['Authorization'].split(' ').last
  #     end
  # end
  #
  # def auth_token
  #   @auth_token ||= JsonWebToken.decode(http_token)
  # end
  #
  # def user_id_in_token?
  #   http_token && auth_token && auth_token[:user_id].to_i
  # end
end
