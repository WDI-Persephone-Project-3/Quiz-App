class SessionsController < ApplicationController

	def new
    if session[:user_class] == "Student"
      redirect_to '/students/dash'
    elsif session[:user_class] == "Instructor"
      redirect_to '/instructors/dash'
    else
      render :new
    end
	end
	
  def create
    user = Instructor.find_by(email: params[:email])
    user = Student.find_by(email: params[:email]) if !user
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_class] = user.class.name
      if user.class.name == "Student"
        redirect_to '/students/dash'
      else
        redirect_to '/instructors/dash'
      end
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_class] = nil
    redirect_to '/'
  end

  def new_user
    if session[:user_class] == "Student"
      redirect_to '/students/dash'
    elsif session[:user_class] == "Instructor"
      redirect_to '/instructors/dash'
    else
      render :new_user
    end
  end

  def create_user
    user = Instructor.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password]) if params[:user] == "Instructor"
    user = Student.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password]) if params[:user] == "Student"
    if user.save
      session[:user_id] = user.id
      session[:user_class] = user.class.name
      if user.class.name == "Student"
        redirect_to '/students/dash'
      else
        redirect_to '/instructors/dash'
      end
    else
      render :new_user
    end
  end

end
