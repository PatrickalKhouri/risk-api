require 'date'

class PersonsController < ApplicationController

  def create
    person = Person.new(person_params)
    person.risk_questions = params[:risk_questions]
    person.ownership_status = params[:house][:ownership_status]
    person.vehicle_year = params[:vehicle][:year]
    if person.valid?
      person.save
      result_json = risk_calculation(person)
      render json: result_json
    else
      error_json = { error: "Status 400" }
      render json: error_json, status: 400
    end
  end

  private

  def risk_calculation(person)
    base_risk = base_risk_calculation(person)
    auto_points = auto(base_risk, person)
    disability_points = disability(base_risk, person)
    home_points = home(base_risk, person)
    life_points = life(base_risk, person)
    result = { auto: auto_points, disability: disability_points, home: home_points, life: life_points }    
    result
  end

  def person_params
    params.require(:person).permit(:age, :dependents, :income, :marital_status,
   risk_questions:[], vehicle: [ :year ], house: [ :ownership_status] )
   end

  def base_risk_calculation(person)
    questions_points = 0
    questions_points = person.risk_questions[0] + person.risk_questions[1] + person.risk_questions[2]

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
    year_points = person.vehicle_year + 5 >= current_year ? 1 : 0
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
