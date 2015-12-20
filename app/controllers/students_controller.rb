class StudentsController < ApplicationController
  
  def index 
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
  #   @student = Student.create({first_name: params[:first_name], last_name: params[:last_name, email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]})
  #   redirect_to @student
  end

  def dash
    @student = Student.find(session[:user_id])
  end
  
  def show
    @student = Student.find(params[:id])
  	if @student == Student.find(session[:user_id])
  	  @quizzes = @student.all_quizzes
  	  @student.sort_quizzes_by_date
      @grades = @student.calculate_grades
    else
      redirect_to "/"
    end  
  end

  def edit
    @student = Student.find(params[:id])
  	if @student == Student.find(session[:user_id])
      render :edit
    else
      redirect_to "/"
    end
  end

  def update
  	@student = Student.find(session[:user_id])
  	@student.update(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    redirect_to @student
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
  end
  
  private

  def student_params
  	params.require(:student).permit(:email, :password, :password_confirmation)
  end

end
