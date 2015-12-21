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
    @student = Student.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

    respond_to do |format|
      if @student.save
        StudentMailer.welcome_email(@student).deliver()
        format.html {redirect_to @student, notice: 'User was successfully created.'}
        format.json {render :show, status: :created, location: @student}
      else
        format.html {render :new}
        format.json {render json: @student.errors, status: :unprocessable_entity}
      end
    end
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

    respond_to do |format|
      if @student.update(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        format.html {redirect_to @student, notice: 'User was successfully updated.'}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    respond_to do |format|
      format.html {redirect_to '/', notice: 'User was successfully destroyed.'}
      format.json {head :no_content}
  end
  
  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
  	params.require(:student).permit(:email, :password, :password_confirmation)
  end

end
