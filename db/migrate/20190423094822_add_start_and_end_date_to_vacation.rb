class AddStartAndEndDateToVacation < ActiveRecord::Migration[5.1]
  def change
    add_column :vacations, :start_date, :datetime
    add_column :vacations, :end_date, :datetime
  end
end
