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

  def calculate_grade(id)
    quiz = Quiz.find(id)
    # If the student hasn't answered the quiz, his grade is a 0
    if !Response.find_by(quiz: quiz, student: self)
      correct_counter = 0
    else
      correct_counter = 0  
      # Else, run through each question and add 1 for each correct choice    
      quiz.questions.map do |question|
        student_response = Response.find_by(question: question, student: self, quiz: quiz).choice
        correct_counter += 1 if student_response == question.correct_answer.choice 
      end     
    end
    correct_counter
  end

  def calculate_grades
    # A student may miss a quiz. In this case, they should get a grade of zero. This method can handle whether or not a student has taken all quizzes in his cohort or whether he's missed one

    # Quiz ids for quizzes the student has taken
  	ids_for_responses = self.responses.pluck(:quiz_id).uniq
    # Quiz ids for quizzes the student has taken ordered by test day - this is important to get a good visualization - otherwise the line chart will not go in order
    quiz_ids_for_responses = Quiz.where(id: ids_for_responses).order(test_day: :asc).pluck(:id)
    # Quiz ids for quizzes in the cohort
    quiz_ids_for_cohort = Quiz.where(cohort: self.cohort).order(test_day: :asc).pluck(:id)
    # Quiz ids for quizzes the student has missed or has not taken yet
    quiz_ids_difference = quiz_ids_for_cohort-quiz_ids_for_responses
    # If there are quizzes the student has missed, replace the quiz id with 0
    i = 0
    if quiz_ids_difference.length>0
      while i<quiz_ids_difference.length
        index = quiz_ids_for_cohort.index(quiz_ids_difference[i])
        quiz_ids_for_cohort[index] = 0
        i += 1
      end
    end

  	quiz_ids_for_cohort.map do |id|
      # If the student missed the quiz, their grade is zero
      if id == 0
        correct_counter = [0]
      else
        correct_counter = 0        
    	  quiz = Quiz.find(id)
    	  questions = quiz.questions
        # Else, loop through each question in the quiz, check against their response, and add one if their choice was correct        
        questions.map do |question|
          student_choice = Response.find_by(question: question, student: self, quiz: quiz).choice
          correct_counter += 1 if student_choice == question.correct_answer.choice
          grade = correct_counter
        end
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
    cohort_avg = students_avg_total.to_f * 100 / students.length.to_f
  end

end