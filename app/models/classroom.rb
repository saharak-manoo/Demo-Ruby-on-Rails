class Classroom < ApplicationRecord
  has_many :subjects

  validates :name, :seat, presence: true
  validates_uniqueness_of :name 
end
