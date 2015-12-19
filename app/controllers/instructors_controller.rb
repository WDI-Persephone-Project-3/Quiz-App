class InstructorsController < ApplicationController

  def dash
    @instructor = Instructor.find(session[:user_id])
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
        last_name:  student.last_name
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

  private 
  def instructor_params
    params.require(:instructor).permit(:email, :password, :password_confirmation)
  end

end
