class Flag < ApplicationRecord
  belongs_to :user
  has_many :entries
  has_many :tracks, through: :entries
  has_many :checkins

  validates :latitude, :presence => true
  validates :longitude, :presence => true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

end
