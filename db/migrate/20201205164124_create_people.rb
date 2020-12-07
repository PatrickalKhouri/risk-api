class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.integer :age
      t.integer :dependents
      t.boolean :house
      t.string :ownership_status
      t.integer :income
      t.string :marital_status
      t.integer :risk_questions, array: true, default: []
      t.boolean :vehicle
      t.integer :year
      t.timestamps
    end
  end
end