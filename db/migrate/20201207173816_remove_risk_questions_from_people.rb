class RemoveRiskQuestionsFromPeople < ActiveRecord::Migration[6.0]
  def change
    remove_column :people, :risk_question_1
  end
end
