class InstructorsController < ApplicationController

  def dash
    @instructor = Instructor.find(current_user.id)
    @students = Student.where(cohort: Cohort.where(instructor: current_user).first)
    @quizzes = Quiz.where(cohort: Cohort.where(instructor: current_user).first).order(test_day: :desc).select{|quiz| quiz.test_day <= Date.today}
    @cohorts = Cohort.where(instructor: current_user)
  end

  def show
    @instructor = Instructor.find(current_user.id)
  end

  def edit  
    @instructor = Instructor.find(current_user.id)
  end

  def update
    @instructor = Instructor.find(current_user.id)
    @instructor.update(instructor_params)
    redirect_to @instructor
  end

  def ajaxCohort
    students = Student.where(cohort: Cohort.find_by(name: "#{params[:cohort_name]}"))
    quizzes = Quiz.where(cohort: Cohort.find_by(name: "#{params[:cohort_name]}")).order(test_day: :desc).select{|quiz| quiz.test_day <= Date.today}
    response = {students: [], quizzes: []}
    students.each do |student|
      response[:students].push({
        id:         student.id,
        first_name: student.first_name,
        last_name:  student.last_name,
        grades: [{quiz_id: 10, grade: rand(100)}, {quiz_id: 9, grade: rand(100)}]
      })
    end
    quizzes.each do |quiz|
      response[:quizzes].push({
        id:       quiz.id,
        test_day: quiz.test_day
      })
    end
    render json: response
  end

  def ajaxQuiz
    grades = [0, 0, 0, 0]
    quiz = Quiz.find_by(cohort: Cohort.find_by(name: params[:cohort_name]),test_day: params[:test_day])
    students = Student.where(cohort: Cohort.find_by(name: params[:cohort_name]))
    response = []
    if quiz.test_day < Date.today
      students.each do |student|
        grade = student.calculate_grade(quiz.id) * 100 / quiz.questions.length
        if grade < 30 
          grades[3] += 1
        elsif grade < 50
          grades[2] += 1
        elsif grade < 70
          grades[1] += 1
        else
          grades[0] += 1
        end
      end
    end

    response = [
      ["70-100%", grades[0]],
      ["50-79%", grades[1]],
      ["30-49%", grades[2]],
      ["Needs Help", grades[3]],
    ]   

    render json: response
  end

  def ajaxStudent
    studentName = params[:name].split('-')
    student = Student.find_by(first_name: studentName[0], last_name: studentName[1])
    quizDates = Quiz.where(cohort: student.cohort).order(test_day: :asc).select{|quiz| quiz.test_day <= Date.today}
    grades = student.calculate_grades
    response = []

    quizDates.each_with_index do |quiz, index|
      parsedDate = Date.parse(quiz.test_day.to_s)
      response.push({
        year: parsedDate.year,
        month: parsedDate.mon,
        day: parsedDate.mday,
        grade: grades[index].last * 100 / quiz.questions.length
        })
    end
    render json: response
  end

  private 
  def instructor_params
    params.require(:instructor).permit(:email, :password, :password_confirmation)
  end

end
