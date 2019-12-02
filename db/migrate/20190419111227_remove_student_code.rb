class RemoveStudentCode < ActiveRecord::Migration[5.1]
  def change
    remove_column :students, :student_code
  end
end
