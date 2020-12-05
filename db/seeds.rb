# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Person.destroy_all

puts 'Creating Person...'

test = Person.create!(age: 50, dependents: 1, house: true, ownership_status: 'mortgaged', income: 300000, marital_status: 'married', 
risk_question_1: false, risk_question_2: true, risk_question_3: true,  vehicle: true, vehicle_year: 2019) 
puts 'Person created!!'