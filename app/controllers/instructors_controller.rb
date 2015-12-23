class InstructorsController < ApplicationController

  def dash
    @instructor = Instructor.find(session[:user_id])
    @students = Student.where(cohort_id: Cohort.where(instructor_id: current_user.id).first.id)
    @quizzes = Quiz.where(cohort_id: Cohort.where(instructor_id: current_user.id).first.id).order(test_day: :desc)
    @cohorts = Cohort.where(instructor_id: current_user.id)
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def edit  
    @instructor = Instructor.find(session[:user_id])
  end

  def update
    @instructor = Instructor.find(session[:user_id])
    @instructor.update(instructor_params)
    redirect_to @instructor
  end

  def ajaxCohort
    students = Student.where(cohort_id: Cohort.find_by(name: "#{params[:cohort_name]}").id)
    quizzes = Quiz.where(cohort_id: Cohort.find_by(name: "#{params[:cohort_name]}").id).order(test_day: :desc)
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
      ["30-59%", grades[2]],
      ["Needs Help", grades[3]],
    ]   

    render json: response
  end

  def ajaxStudent
    studentName = params[:name].split('-')
    student = Student.find_by(first_name: studentName[0], last_name: studentName[1])
    quizDates = Quiz.where(cohort: student.cohort).order(test_day: :asc) 
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
