class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, PictureUploader

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  has_many :flags, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :tracks, through: :entries
  has_many :checkins

  acts_as_voter

  def active_checkin
    self.checkins.active[0] if self.checkins.active.length > 0
  end

end
