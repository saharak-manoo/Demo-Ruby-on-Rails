class Subject < ApplicationRecord
  has_many :register_courses, class_name: "RegisterCourse", foreign_key: "subject_id"
  belongs_to :classroom
end
