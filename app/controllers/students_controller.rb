class StudentsController < ApplicationController

  def new
    @student = Student.new
    @cohorts = Cohort.where(instructor_id: session[:user_id])
  end

  def create
    @default_pw = "123"
    @student = Student.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: @default_pw, password_confirmation: @default_pw, cohort: Cohort.find_by(name: params[:cohort]))

    redirect_to "/"
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
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
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

  def ajax
    quizDates = Quiz.where(cohort: current_user.cohort).order(test_day: :asc).select{|quiz| quiz.test_day <= Date.today}
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

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
  	params.require(:student).permit(:email, :password, :password_confirmation)
  end

end
