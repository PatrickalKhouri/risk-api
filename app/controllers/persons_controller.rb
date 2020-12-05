class PersonsController < ApplicationController

  def test

    testing = {key: 'value' }

    render json: testing
  end
end
