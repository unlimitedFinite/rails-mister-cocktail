class Cocktail < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :doses, :dependent => :delete_all
  has_many :ingredients, :through => :doses
  validates :name, :description, presence: true, uniqueness: true
end
