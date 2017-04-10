class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode 

  has_many :flags, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :tracks, through: :entries
end
