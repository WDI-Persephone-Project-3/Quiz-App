class Quiz < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :cohort
  has_many :responses
  has_and_belongs_to_many :questions

  # method for getting a list of pre-existing questions for the drop down

  # method for checkbox? 

  # QUESTIONS = []
  # QUESTIONS.push(Question.all)
  # QUESTIONS.flatten

  # Quiz.pluck(:questions).where(quiz_id: @self.id)
end