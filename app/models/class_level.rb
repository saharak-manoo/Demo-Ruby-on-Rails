class ClassLevel < ApplicationRecord
  has_one :student, class_name: "Student", foreign_key: "class_level_id"
end
