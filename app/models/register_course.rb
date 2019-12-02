class RegisterCourse < ApplicationRecord
  acts_as_paranoid
  belongs_to :student, class_name: "Student", foreign_key: "student_id"
  belongs_to :subject, class_name: "Subject", foreign_key: "subject_id"

  validates :subject_id, :student_id, presence: true
  validates_uniqueness_of :subject_id, scope: :student_id
  validate :prohibit_less_than_zero

  def prohibit_less_than_zero
    errors.add(:base, "คุณลงทะเบียนเยอะเกินจำนวนหน่วยกิต") if (student.decorate.sum_credits - subject.credit) < 0 unless subject&.credit.nil?
  end

  def uniqueness_subject
    count = RegisterCourse.where(student_id: student.id, subject_id: subject.id).count + 1

    if count > 1
      errors.add(:base, "คุณลงทะเบียนวิชาซ้ำกัน")
      return false
    else
      return true
    end
  end
end
