class CreateVacation < ActiveRecord::Migration[5.1]
  def change
    create_table :vacations do |t|
      t.string :detail
      t.string :leave_type

      t.timestamps
    end
  end
end
