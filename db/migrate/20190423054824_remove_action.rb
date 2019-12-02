class RemoveAction < ActiveRecord::Migration[5.1]
  def up
    remove_column :register_courses, :action
  end

  def down
    add_column :register_courses, :action, :string
  end
end
