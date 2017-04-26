class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_login
    redirect_to splash_path unless current_user
  end

  def set_flag_by_id
    flag_id = params[:flag_id]
    @flag = Flag.find_by_id(flag_id)
  end

  #for omniauth
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  private

  def set_user_location
    if params[:lat] && params[:lon]
        current_user.update({
        latitude: params[:lat].to_f,
        longitude: params[:lon].to_f,
        last_ping_time: DateTime.now().utc
        })
      if !!current_user.active_checkin
        checkout unless user_nearby?(current_user.active_checkin.flag)
      end
    end
  end

  def user_nearby?(flag)
    Flag.near([current_user.latitude, current_user.longitude], 0.5, :units => :mi).include?(flag)
  end

  def checkout
    current_user.active_checkin.inactive! if !!current_user.active_checkin
  end

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
    Track.reindex
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
