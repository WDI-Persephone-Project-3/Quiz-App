class Student < ActiveRecord::Base
  has_secure_password
  has_many :responses
  belongs_to :cohort
  # belongs_to :instructor, through: :cohort
  
  def all_quizzes
  	array_of_quiz_ids = self.responses.pluck(:quiz_id).uniq
  	array_of_quiz_ids.each do |id|
  	  quiz = Quiz.find(id).test_day
  	end
  end

  def calculate_grades
  	correct_counter = 0
  	array_of_quiz_ids = self.responses.pluck(:quiz_id).uniq
  	array_of_quiz_ids.each do |id|
  	  quiz = Quiz.find(id)
  	  questions = quiz.questions
    end
  	questions.each do |question|
  	  student_response = Response.find_by(quiz_id: question.quizzes.id).choice
  	  question = Response.find_by(question_id: question.id)
      correct_counter += 1 if student_response == questions.answers.where(is_correct: true)
  	  grade = correct_counter 
  	end
  end

  def sort_quizzes_by_date
    array_of_quiz_ids = self.responses.pluck(:quiz_id).uniq
  	quizzes = array_of_quiz_ids.each do |id|
  	  Quiz.find(id)
  	end
  	sorted_quizzes_by_date = quizzes.sort do |quiz1, quiz2|
  	  quiz1_date = quiz1.test_day
  	  quiz2_date = quiz2.test_day
  	  quiz2_date <=> quiz1_date
  	end 
  end
  
  def sort_quizzes_by_grade

  end

end