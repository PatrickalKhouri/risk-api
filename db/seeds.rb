# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Person.destroy_all

puts 'Creating Person...'

test = Person.create!(age: 25, dependents: 0, house: false, ownership_status: 'owned', income: 20000, marital_status: 'single', 
risk_question_1: false, risk_question_2: true, risk_question_3: false,  vehicle: true, year: 2019) 

puts 'Person created!!'