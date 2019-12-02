class AddDeletedAtToRegisterCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :register_courses, :deleted_at, :datetime
    add_index :register_courses, :deleted_at
  end
end
