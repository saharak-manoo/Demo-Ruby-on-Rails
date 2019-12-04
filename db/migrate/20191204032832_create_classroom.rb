class CreateClassroom < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.integer :seat, null: false
      t.boolean :active, default: false
      
      t.timestamps
    end
  end
end
