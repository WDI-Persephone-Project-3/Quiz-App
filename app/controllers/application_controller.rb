class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:user_class] == "Student"
    @current_user ||= Student.find(session[:user_id])
    elsif session[:user_class] == "Instructor" 
    @current_user ||= Instructor.find(session[:user_id])
    end
  end

  def todays_quiz
    Quiz.where(cohort: current_user.cohort, test_day: Date.today)
  end

  helper_method :current_user, :todays_quiz

end
