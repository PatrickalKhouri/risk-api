class PersonsController < ApplicationController

  def risk_calculation

    result = Person.first
    
    render json: result
  end
end
