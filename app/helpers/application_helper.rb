module ApplicationHelper

  def entry_for_vote(vote)
    Entry.find_by_id(vote.votable_id)
  end

end
