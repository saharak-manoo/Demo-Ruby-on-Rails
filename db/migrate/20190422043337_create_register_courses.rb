class CreateRegisterCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :register_courses do |t|
      t.string :action

      t.timestamps
    end
  end
end
