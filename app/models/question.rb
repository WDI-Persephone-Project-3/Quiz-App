class Question < ActiveRecord::Base
  has_and_belongs_to_many :quizzes
  has_many :answers
  has_one :response

  def correct_answer
  	@correct = self.answers.find_by(is_correct: true)
  end

end