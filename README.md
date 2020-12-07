# README

Ruby 2.6.6
Framework - Rails 6
Database - Postgresql


--Install dependencies:

$ bundle install && yarn install

--Run Database migrations:

$ rails db:migrate

-- Start server: 

$ rails s

-- Post request endpoint: 

POST http://localhost:3000/risk-evaluation

-- Content type:

application/json

-- Body example: 
{
  "age": 35,
  "dependents": 2,
  "house": {"ownership_status": "owned"},
  "income": 0,
  "marital_status": "married",
  "risk_questions": [0, 1, 0],
  "vehicle": {"year": 2018}
}

-- Run Tests: 

$ rspec

## Tecnical Decisions ## 

Firstly, i would like to thank Origin for giving the opportunity of doing this test, even If I don't pass the evaluation i've alreay learned A LOT.

I did the project in Rails since its the framework that I am the most comfortable with, since I have never done an API before, and have never worked with automated tests, i decided to focus initially on the algorigth itself. 

When doing the algorithm i decided to split the code in bit by line of insurance, this breaks the code in smaller bits, makes it easier to debug and if any alteration is made to the business rules, they become easy to find where to alter the code.

Then I did the automated test, and I know that ideally a TDD would be the ideal, and on a next project i would have a TDD approach.

And lastly I did the route and json payload, another first for me. Using postgres sql allowed me to have an array for the risk questions, while sqlite doesn't allow it.

I know there are improvements to be done, but once again, i was able to learn a lot from this test.





