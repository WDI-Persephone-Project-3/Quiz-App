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
    @cohort = @student.cohort
    quizzes = Quiz.where(cohort: @cohort).order(test_day: :desc)
    @quizzes = quizzes.select do |quiz|
      quiz.test_day <= Date.today
    end
    @responses = Response.where(student: @student)
    @todaysQuiz = @quizzes.select{|quiz| quiz.test_day == Date.today}
  end
  
  def show
    @student = Student.find(params[:id])
  	if @student == Student.find(session[:user_id]) || current_user.class == Instructor
  	  @quizzes = @student.all_quizzes
  	  @student.sort_quizzes_by_date
      @grades = @student.calculate_grades
      @average = @student.current_average
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

  def ajax
    existingResponses = Response.where(student: current_user).pluck(:quiz_id).uniq
    quizDates = Quiz.where(id: existingResponses).order(test_day: :asc)
    grades = current_user.calculate_grades
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

  def student_params
  	params.require(:student).permit(:email, :password, :password_confirmation)
  end

end
