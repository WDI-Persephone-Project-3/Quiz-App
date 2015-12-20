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

  def cohort
    students = Student.where(cohort_id: Cohort.find_by(name: "#{params[:name]}").id)
    quizzes = Quiz.where(cohort_id: Cohort.find_by(name: "#{params[:name]}").id).order(test_day: :desc)
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

  def quiz
    response = [
      ["90-100%", rand(10)],
      ["80-89%", rand(10)],
      ["70-79%", rand(10)],
      ["60-69%", rand(10)],
      ["Needs Help", rand(10)]
    ]
    render json: response
  end

  def student
    response = [
      [2015,12,13,100], [2015,12,14,100], [2015,12,15,100], [2015,12,16,100], [2015,12,17,100], [2015,12,18,100], [2015,12,20,100]
    ]
    render json: response
  end

  private 
  def instructor_params
    params.require(:instructor).permit(:email, :password, :password_confirmation)
  end

end
