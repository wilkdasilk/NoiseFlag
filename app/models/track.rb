class Track < ApplicationRecord

  searchkick word_start: [:name, :artist, :album]
  has_many :entries
  has_many :flags, through: :entries
end
