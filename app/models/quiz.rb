class Quiz < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :cohort
  has_many :responses
  has_and_belongs_to_many :questions

  # QUESTIONS = []
  # QUESTIONS.push(Question.all)
  # QUESTIONS.flatten

  # Quiz.pluck(:questions).where(quiz_id: @self.id)
end