class Flag < ApplicationRecord
  belongs_to :user
  has_many :entries
  has_many :tracks, through: :entries

end
