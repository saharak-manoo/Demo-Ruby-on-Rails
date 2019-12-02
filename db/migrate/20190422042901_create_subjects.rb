class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :credit
      t.string :subject_code

      t.timestamps
    end
  end
end
