require 'date'

class PersonsController < ApplicationController

  def create
    person = Person.new(person_params)
    if person.valid?
      render json: person
    else
      #error
    end

  def risk_calculation

    person = Person.last
    base_risk = base_risk_calculation(person)
    auto_points = auto(base_risk, person)
    disability_points = disability(base_risk, person)
    home_points = home(base_risk, person)
    life_points = life(base_risk, person)

    result = { auto: auto_points, disability: disability_points, home: home_points, life: life_points }    
    render json: result
  end

  private 

  def person_params
    params.require(:person).permit(:age, :dependents, :house { :ownership_status }, :income, :marital_status,
    :risk_question_1, :risk_question_2, :risk_question_3, :vehicle { :vehicle_year } )
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

    current_year = DateTime.now.year
    year_points = person.vehicle_year + 5 > current_year ? 1 : 0
    points = base_risk + year_points
    auto_points = outcome(points)
    auto_points
  end

  def disability(base_risk, person)
    return "ineligible" if person.income == 0 || person.age > 60
    
    morgage_points = person.ownership_status == "mortgaged" ? 1 : 0
    dependent_points = person.dependents >= 1 ? 1 : 0
    marital_points = person.marital_status == "married" ? 1 : 0
    points = base_risk + morgage_points + dependent_points - marital_points
    disability_points = outcome(points)
    disability_points
  end
  
  def home(base_risk, person)
    return "ineligible" if !person.house

    morgage_points = person.ownership_status == "mortgaged" ? 1 : 0
    points = base_risk + morgage_points
    home_points = outcome(points)
    home_points
  end

  def life(base_risk, person)
    return "ineligible" if person.age > 60

    dependent_points = person.dependents >= 1 ? 1 : 0
    marital_points = person.marital_status == "married" ? 1 : 0
    points = base_risk + dependent_points + marital_points
    life_points = outcome(points)
    life_points
  end

 def outcome(points)
  case 
  when points >= 3 
    "responsible"
  when points >= 1 &&  points < 3
    "regular"
  when points <= 0
    "economic"
    end
  end

end
