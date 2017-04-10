module FlagsHelper

  def have_recent_location?
    current_user.latitude && current_user.longitude && !!current_user.last_ping_time && current_user.last_ping_time > 2.minutes.ago
  end

  def have_current_location?
    current_user.latitude && current_user.longitude && !!current_user.last_ping_time && current_user.last_ping_time > 30.seconds.ago
  end
  
end
