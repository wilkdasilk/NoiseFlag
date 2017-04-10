class Checkin < ApplicationRecord
  belongs_to :user
  belongs_to :flag

  enum status: [ :inactive, :active ]

end
