class Student < ApplicationRecord
  acts_as_paranoid
  belongs_to :class_level, class_name: "ClassLevel", foreign_key: "class_level_id"
  has_many :register_courses, class_name: "RegisterCourse", foreign_key: "student_id"
  has_many :vacations, class_name: "Vacation", foreign_key: "student_id"

  validates :first_name, :last_name, :status, :class_level_id, :total_vacation, presence: true
  validates_uniqueness_of :first_name, scope: :last_name

  def studying?
    status == 'กำลังศึกษา'
  end

  def graduate?
    status == 'จบการศึกษา'
  end

  def resign?
    status == 'ลาออก'
  end
end
