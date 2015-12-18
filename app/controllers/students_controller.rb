class StudentsController < ApplicationController

  def dash
  end
  
  def show
  	@student = Student.find(params[:id])
  	@quizzes = @student.all_quizzes
  	@grades = @student.calculate_grades
  	@date_sorted_quizzes = @student.sort_quizzes_by_date
  end

  def edit
  	render :edit 
  end

  def update
  	@student = Student.find(params[:id])
  	@student.update(student_params)
  end

  def student_params
  	params.require(:student).permit(:email, :password, :password_confirmation)
  end

end
