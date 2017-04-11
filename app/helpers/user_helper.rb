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

end
