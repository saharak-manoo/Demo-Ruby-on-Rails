class AddTotalVacationToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :total_vacation, :integer, default: 7
  end
end
