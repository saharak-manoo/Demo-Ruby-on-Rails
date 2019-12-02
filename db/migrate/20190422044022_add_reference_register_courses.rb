class AddReferenceRegisterCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :register_courses, :subject, foreign_key: { to_table: :subjects }
    add_reference :register_courses, :student, foreign_key: { to_table: :students }
  end
end
