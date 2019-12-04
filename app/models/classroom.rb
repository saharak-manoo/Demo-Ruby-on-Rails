class Classroom < ApplicationRecord
  validates :name, :seat, presence: true
  validates_uniqueness_of :name
end
