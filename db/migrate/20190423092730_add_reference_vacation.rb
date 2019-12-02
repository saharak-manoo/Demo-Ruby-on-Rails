class AddReferenceVacation < ActiveRecord::Migration[5.1]
  def change
    add_reference :vacations, :student, foreign_key: { to_table: :students }
  end
end
