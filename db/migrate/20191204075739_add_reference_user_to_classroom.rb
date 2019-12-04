class AddReferenceUserToClassroom < ActiveRecord::Migration[5.1]
  def change
    add_column :classrooms, :created_by, :string
    add_column :classrooms, :updated_by, :string

    add_reference :subjects, :classroom, foreign_key: { to_table: :classrooms }
  end
end