class RemoveRiskQuestion2FromPeople < ActiveRecord::Migration[6.0]
  def change
    remove_column :people, :risk_question_2
  end
end
