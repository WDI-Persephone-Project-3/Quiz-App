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
    render json: '{"name":"Cohort1"}'
  end

  private 
  def instructor_params
    params.require(:instructor).permit(:email, :password, :password_confirmation)
  end

end
