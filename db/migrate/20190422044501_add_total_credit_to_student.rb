class AddTotalCreditToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :credits_earned, :integer, default: 10
  end
end
