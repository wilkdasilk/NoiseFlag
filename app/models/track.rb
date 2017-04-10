class Track < ApplicationRecord

  searchkick
  has_many :entries
  has_many :flags, through: :entries
end
