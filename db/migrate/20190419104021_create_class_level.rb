class CreateClassLevel < ActiveRecord::Migration[5.1]
  def change
    create_table :class_levels do |t|
      t.string :name

      t.timestamps
    end
  end
end
