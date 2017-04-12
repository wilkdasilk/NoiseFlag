class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:spotify]

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

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name
       user.picture = auth.info.image
     end
  end

end
