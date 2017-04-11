class Entry < ApplicationRecord

  belongs_to :track
  belongs_to :flag
  belongs_to :user

  acts_as_votable
end
