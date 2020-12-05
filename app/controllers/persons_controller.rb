require 'date'

class PersonsController < ApplicationController

  def risk_calculation

    person = Person.first
    base_risk = base_risk_calculation(person)

    
    render json: result
  end

  def base_risk_calculation(person)
    question_1 = person.risk_question_1 ? 1 : 0
    question_2 = person.risk_question_2 ? 1 : 0
    question_3 = person.risk_question_3 ? 1 : 0

    questions_points = question_1 + question_2 + question_3
    
    if person.age < 30
      age_points = 2
    elsif person.age <= 40
      age_points = 1
    else
      age_points = 0
    end

    income_points = person.income > 200000 ? 1 : 0

    base_risk = questions_points - age_points - income_points
    base_risk
  end

  def auto(base_risk, person)
    return "ineligible" if !person.vehicle

    current_year = Date.now.year
    year_points = person.vehicle + 5 > current_year ? 1 : 0
    points = base_risk + year_points
    auto_points = outcome(points)
    auto_points
  end

  def disability(base_risk, person)
    return "ineligible" if person.income == 0 || person.age > 60
    
    morgage_points = person.ownership_status = "mortgaged" ? 1 : 0
    dependent_points = person.dependents >= 1 ? 1 : 0
  end
  
  def home(base_risk)
  end

  def life(base_risk)
  end

  def outcome(points)
    case points
    when >= 3 
      "responsible"
    when >= 1 && < 3
      "regular"
    when <= 0
      "economic"
    end
  end
end
