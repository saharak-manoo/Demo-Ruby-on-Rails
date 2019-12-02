class Vacation < ApplicationRecord
  attr_accessor :half_day
  belongs_to :student, class_name: "Student", foreign_key: "student_id"

  validates :detail, :leave_type, :student_id, :start_date, :end_date, presence: true
  validate :end_date_is_after_start_date, :start_date_cannot_be_in_the_past, :check_vacation

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "ไม่สามารถลาย้อนหลังได้") if start_date.present? && start_date < Date.today
  end

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "ไม่สามารถอยู่ก่อนวันที่เริ่มต้น") if end_date < start_date
  end

  def check_vacation
    errors.add(:base, "มีการลาในช่วงวันเหล่านี้แล้ว") unless Vacation.where(start_date: start_date..end_date, end_date: start_date..end_date, student_id: student_id).blank?
  end

  def half_day?
    leave_type == 'Half-day leave'
  end
end
