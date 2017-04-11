module FlagsHelper

  def have_recent_location?
    current_user.latitude && current_user.longitude && !!current_user.last_ping_time && current_user.last_ping_time >= 2.minutes.ago.utc
  end

  def have_current_location?
    current_user.latitude && current_user.longitude && !!current_user.last_ping_time && current_user.last_ping_time >= 30.seconds.ago.utc
  end

  def markers_string(flags)
    return "" if !flags
    flags.inject("") do |str, flag|
      str +  "|#{flag.latitude},#{flag.longitude}"
    end
  end

  def center
    return params[:center] if !!params[:center] && params[:center] !=""
    return "#{current_user.latitude},#{current_user.longitude}" if !!current_user.latitude & !!current_user.longitude
    return current_user.current_city
  end

  private

  def user_checked_in?(flag)
    if current_user.checkins.active.length > 0
      current_user.checkins.active[0].flag == flag
    end
  end

  def user_near_flag?(flag)
    results = Flag.near([current_user.latitude, current_user.longitude], 0.5, :units => :mi).include?(flag)
  end

end
