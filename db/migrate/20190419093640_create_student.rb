class CreateStudent < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :student_code
      t.string :first_name
      t.string :last_name
      t.string :status

      t.timestamps
    end
  end
end
