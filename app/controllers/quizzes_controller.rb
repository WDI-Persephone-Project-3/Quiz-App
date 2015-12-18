class QuizzesController < ApplicationController

  # GET '/quizzes'
  def index
    @quizzes = Quiz.where(instructor_id: current_user.id) if current_user.class == Instructor
    @quizzes = Quiz.where(cohort_id: Student.find(current_user.id).cohort_id) if current_user.class == Student
  end

  # GET '/quizzes/1'
  def show
    @quiz = Quiz.find(params[:id])
  end

  # GET '/quizzes/new'
  def new
    @quiz = Quiz.find(params[:id])
    @question = @quiz.questions.build
    @answer = @question.answers.build
  end

  # POST '/quizzes'
  def create
    @quiz = Quiz.new(test_day: params[:test_day], instructor_id: params[:instructor_id], cohort_id: params[:cohort_id])
    if @quiz.save
      redirect_to '/quizzes'
    else
      render :new
    end
  end

end
