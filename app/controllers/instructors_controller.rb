class InstructorsController < ApplicationController

  def dash
    @instructor = Instructor.find(session[:user_id])
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def new
    @instructor = Instructor.new
  end

  def edit  
    @instructor = Instructor.find(session[:user_id])
  end

  def update
    @instructor = Instructor.find(session[:user_id])
    @instructor.update(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    redirect_to @instructor
  end

  def create
    @instructor = Instructor.create(instructor_params)

    redirect_to @instructor
  end

  def cohort
    render json: '{"name":"Cohort1"}'
  end

  private 
  def instructor_params
    params.require(:instructor).permit(:last_name, :first_name, :email, :password, :password_confirmation)
  end

end
