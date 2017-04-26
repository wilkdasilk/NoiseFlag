module UserHelper

  def actions(user)
    result = []
    user.flags.each do |flag|
      result << flag
    end
    user.entries.each do |entry|
      result << entry
    end
    user.votes.each do |vote|
      result << vote
    end
    user.checkins.each do |checkin|
      result << checkin
    end
    @list = result.sort { |y, x| x.created_at <=> y.created_at }
    @list = @list.paginate(:page => params[:page], :per_page => 10)
  end

  def user_img_or_default(user)
    return default_img_url if user.picture.file.nil?
    user.picture_url(:profile)
  end

  private

  def default_img_url
    asset_path('user.ico')
  end

end
