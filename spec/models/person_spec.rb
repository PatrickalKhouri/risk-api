require 'rails_helper'
require 'date'

RSpec.describe Person, type: :model do
  context "validation tests" do
    it 'ensures age presence' do
      person = Person.new(dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'married', 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures income presence' do
      person = Person.new(dependents: 1, house: true, ownership_status: 'mortgaged', age: 30, marital_status: 'married', 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures dependents presence' do
      person = Person.new(age: 30, house: true, ownership_status: 'mortgaged', income: 30000, marital_status: 'married', 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures marital status presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures house presence' do
      person = Person.new(dependents: 30, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures risk question 1 presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_questions: [],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'ensures vehicle presence' do
      person = Person.new(dependents: 30, house: true, ownership_status: 'mortgaged', income: 30000, age: 30, 
      risk_questions: [0, 1, 0], vehicle_year: 2019).save
      expect(person).to eq(false) 
    end

    it 'should test values of marital status' do
    person = Person.new(age: 50, dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'other', 
    risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
    expect(person).to eq(false)
    end

    it 'should test values of ownership status' do
    person = Person.new(age: 50, dependents: 1, house: true, ownership_status: 'other', income: 300000, marital_status: 'single', 
    risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
    expect(person).to eq(false)
    end

    it "age can't be lower than 0" do
      person = Person.new(age: -5, dependents: 1, house: true, ownership_status: 'owned', income: 300000, marital_status: 'single', 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false)
    end

    it "dependents can't be lower than 0" do
      person = Person.new(age: 25, dependents: -1, house: true, ownership_status: 'owned', income: 300000, marital_status: 'single', 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false)
    end

    it "income can't be lower than 0" do
      person = Person.new(age: 25, dependents: 1, house: true, ownership_status: 'owned', income: -300000, marital_status: 'single', 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(false)
    end

    it 'should save sucessfully' do
      person = Person.new(age: 50, dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'married', 
      risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019).save
      expect(person).to eq(true)
    end
  end

  context "controller tests" do
    context 'base points' do
      it 'question points should add when answer is true' do
        person = Person.create(age: 50, dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019)
        questions_points = 0
        person.risk_questions.each { |question| questions_points += question}
        expect(questions_points).to eq(1)
      end

      it 'the age of the person should deduct points off the base risk points' do
        person = Person.create(age: 29, dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019)
        age_points = 2 if person.age < 30     
        expect(age_points).to eq(2)
      end

      it 'high income should deduct points off the base risk points' do
        person = Person.create(age: 29, dependents: 1, house: true, ownership_status: 'mortgaged', income: 200001, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2019)
        income_points = person.income > 200000 ? 1 : 0    
        expect(income_points).to eq(1)
      end
    end

    context 'auto points' do
      it 'ineligible if person doesnt have a car' do
        person = Person.create(age: 29, dependents: 1, house: false, ownership_status: 'mortgaged', income: 200001, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        result = "ineligible" if !person.vehicle
        expect(result).to eq("ineligible")
      end

      it 'older cars should add points of the auto points' do
        person = Person.create(age: 29, dependents: 1, house: true, ownership_status: 'mortgaged', income: 200001, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: true, vehicle_year: 2015)
        current_year = DateTime.now.year
        year_points = person.vehicle_year + 5 >= current_year ? 1 : 0
        expect(year_points).to eq(1)
      end
    end

    context 'disability points' do
      it 'ineligible if person doesnt have income' do 
        person = Person.create(age: 29, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        result = "ineligible" if person.income == 0
        expect(result).to eq("ineligible")
      end

      it 'ineligible if person is older than 60' do 
        person = Person.create(age: 61, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        result = "ineligible" if person.age > 0
        expect(result).to eq("ineligible")
      end

      it 'If house is mortgaged then add one point to the disability points' do 
        person = Person.create(age: 61, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        morgage_points = person.ownership_status == "mortgaged" ? 1 : 0
        expect(morgage_points).to eq(1)
      end

      it 'If person has dependents then add one point to the disability points' do 
        person = Person.create(age: 61, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        dependent_points = person.dependents >= 1 ? 1 : 0
        expect(dependent_points).to eq(1)
      end

      it 'If person is married then deduct one point to the disability points' do 
        person = Person.create(age: 61, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        marital_points = person.marital_status == "married" ? 1 : 0
        expect(marital_points).to eq(1)
      end
    end

    context 'house points' do
      it 'ineligible if person doesnt have a house' do
        person = Person.create(age: 29, dependents: 1, house: false, ownership_status: 'mortgaged', income: 200001, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        result = "ineligible" if !person.house
        expect(result).to eq("ineligible")
      end

      it 'If house is mortgaged then add one point to the house points' do
        person = Person.create(age: 61, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        morgage_points = person.ownership_status == "mortgaged" ? 1 : 0
        expect(morgage_points).to eq(1)
      end
    end

    context 'life points' do
      it 'If person is married then  one point to the life points' do 
        person = Person.create(age: 61, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        marital_points = person.marital_status == "married" ? 1 : 0
        expect(marital_points).to eq(1)
      end

      it 'If person has dependents then add one point to the disability points' do 
        person = Person.create(age: 61, dependents: 1, house: false, ownership_status: 'mortgaged', income: 0, marital_status: 'married', 
        risk_questions: [0, 1, 0],  vehicle: false, vehicle_year: 2019)
        dependent_points = person.dependents >= 1 ? 1 : 0
        expect(dependent_points).to eq(1)
      end
    end

    context  'output' do
      it 'returns economic if points are 0 or less' do
        points = 0
        case 
        when points >= 3 
          result ="responsible"
        when points >= 1 &&  points < 3
          result = "regular"
        when points <= 0
         result = "economic"
        end

        expect(result).to eq("economic")

      end

      it 'returns regular if points are 1 or 2' do
        points = 2
        case 
        when points >= 3 
          result ="responsible"
        when points >= 1 &&  points < 3
          result = "regular"
        when points <= 0
         result = "economic"
        end

        expect(result).to eq("regular")
      end

      it 'returns responsible if points are 3 or above' do
        points = 4
        case 
        when points >= 3 
          result ="responsible"
        when points >= 1 &&  points < 3
          result = "regular"
        when points <= 0
         result = "economic"
        end

        expect(result).to eq("responsible")
      end


    end
  end
end
