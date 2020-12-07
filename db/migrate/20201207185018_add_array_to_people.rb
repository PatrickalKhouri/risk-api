class AddArrayToPeople < ActiveRecord::Migration[6.0]
  def change
    change_column :people, :risk_questions, :integer, array: true, default: []
  end
end
    