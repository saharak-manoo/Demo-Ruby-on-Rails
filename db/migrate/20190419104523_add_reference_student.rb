class AddReferenceStudent < ActiveRecord::Migration[5.1]
  def change
    add_reference :students, :class_level, foreign_key: { to_table: :class_levels }
  end
end
