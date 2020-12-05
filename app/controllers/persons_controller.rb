class PersonsController < ApplicationController

  def risk_calculation

    @person = Person.first

    render json: result
  end


  private

  def base_risk_calculation
    question_1 = @person.risk_question_1 ? 1 : 0
    question_2 = @person.risk_question_2 ? 1 : 0
    question_3 = @person.risk_question_3 ? 1 : 0

    questions_points = question_1 + question_2 + question_3
    
    if @person.age < 30
      age_points = 2
    elsif @person.age <= 40
      age_points = 1
    else
      age_points = 0
    end

    income_points = @person.income > 200000 ? 1 : 0

    base_risk = questions_points - age_points - income_points
    base_risk
  end

  def outcome(insurance_line)
    case insurance_line
    when >= 3 
      "responsible"
    when >= 1 && < 3
      "regular"
    when <= 0
      "economic"
    end

end
