require 'rails_helper'

RSpec.describe Person, type: :model do
  context "validation tests" do
    it 'ensures age presence' do
      person = Person.new(dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'married', 
      risk_question_1: false, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures income presence' do
      person = Person.new(dependents: 1, house: true, ownership_status: 'mortgaged', age: 30, marital_status: 'married', 
      risk_question_1: false, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures dependents presence' do
      person = Person.new(age: 30, house: true, ownership_status: 'mortgaged', income: 30000, marital_status: 'married', 
      risk_question_1: false, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures marital status presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_question_1: false, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures house presence' do
      person = Person.new(dependents: 30, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_question_1: false, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures risk question 1 presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures risk question 2 presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_question_1: false, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures risk question 3 presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_question_1: false, risk_question_2: true, vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures vehicle presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_question_1: false, risk_question_2: true, risk_question_3: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'should test values of marital status' do
    person = Person.new(age: 50, dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'other', 
    risk_question_1: true, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
    expect(person).to eq(false)
    end

    it 'should test values of ownership status' do
    person = Person.new(age: 50, dependents: 1, house: true, ownership_status: 'other', income: 300000, marital_status: 'single', 
    risk_question_1: true, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
    expect(person).to eq(false)
    end

    it "age can't be lower than 0" do
      person = Person.new(age: -5, dependents: 1, house: true, ownership_status: 'owned', income: 300000, marital_status: 'single', 
      risk_question_1: true, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false)
    end

    it "dependents can't be lower than 0" do
      person = Person.new(age: 25, dependents: -1, house: true, ownership_status: 'owned', income: 300000, marital_status: 'single', 
      risk_question_1: true, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false)
    end

    it "income can't be lower than 0" do
      person = Person.new(age: 25, dependents: 1, house: true, ownership_status: 'owned', income: -300000, marital_status: 'single', 
      risk_question_1: true, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false)
    end

    it 'should save sucessfully' do
      person = Person.new(age: 50, dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'married', 
      risk_question_1: false, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(true)
    end

  end
  
end
