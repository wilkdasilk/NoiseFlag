class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  geocoded_by :current_city
  after_validation :geocode, :if => :address_changed?

  has_many :flags, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :tracks, through: :entries
end
