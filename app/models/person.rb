class Person < ApplicationRecord
  validates :age, :dependents, :marital_status, :income,  presence: true
  validates :house, :vehicle, :risk_question_1, :risk_question_2, :risk_question_3, inclusion: { in: [true, false]}
  validates :marital_status, inclusion: { in: ['single', 'married'] }
  validates :ownership_status, inclusion: { in: ['owned', 'mortgaged']}
  validates :age, :dependents, :income, :numericality => { greater_than_or_equal_to: 0}
end
