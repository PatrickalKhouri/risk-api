class ChangeRiskQuestion3Name < ActiveRecord::Migration[6.0]
  def change
    rename_column :people, :risk_question_3, :risk_questions
  end
end
