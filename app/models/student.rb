class Student < ActiveRecord::Base
  has_secure_password
  has_many :responses
  belongs_to :cohort
  # belongs_to :instructor, through: :cohort
  
  def all_quizzes
  	array_of_quiz_ids = self.responses.pluck(:quiz_id).uniq
  	quizzes = array_of_quiz_ids.map do |id|
  	  Quiz.find(id)
  	end
    quizzes
  end

  def calculate_grades
  	correct_counter = 0
  	array_of_quiz_ids = self.responses.pluck(:quiz_id).uniq
  	array_of_quiz_ids.map do |id|
  	  quiz = Quiz.find(id)
  	  questions = quiz.questions
      questions.map do |question|
        student_response = Response.find_by(question_id: question.id).choice
        correct_counter += 1 if student_response == question.correct_answer.choice
        grade = correct_counter
      end
    end
  end

  def sort_quizzes_by_date
    array_of_quiz_ids = self.responses.pluck(:quiz_id).uniq
  	quizzes = array_of_quiz_ids.map do |id|
  	  Quiz.find(id)
  	end
  	sorted_quizzes_by_date = quizzes.sort do |quiz1, quiz2|
  	  quiz1_date = quiz1.test_day
  	  quiz2_date = quiz2.test_day
  	  quiz2_date <=> quiz1_date
  	end 
    sorted_quizzes_by_date
  end
  
  def sort_quizzes_by_grade
  end

  def current_average
    array_of_quiz_ids = self.responses.pluck(:quiz_id).uniq
    quizzes = array_of_quiz_ids.map do |id|
      Quiz.find(id)
    end
    totals = quizzes.map do |quiz|
      quiz.questions.length
    end
    quiz_total = totals.reduce(:+)
    grades = self.calculate_grades
    all_grades = grades.map do |grade|
      grade[0]
    end
    student_total = all_grades.reduce(:+)
    student_average = student_total.to_f / quiz_total.to_f * 100
  end

  def self.cohort_average
    students = Student.all
    all_students_avg = students.map do |student|
      student.current_average
    end
    students_avg_total = all_students_avg.reduce(:+)
    cohort_avg = students_avg_total.to_f / students.length.to_f * 100
  end

end