class QuizzesController < ApplicationController

  # GET '/quizzes'
  def index
    @quizzes = Quiz.where(instructor_id: current_user.id) if current_user.class == Instructor
    @quizzes = Quiz.where(cohort_id: Student.find(current_user.id).cohort_id) if current_user.class == Student
  end

  # GET '/quizzes/1'
  def show
    @quiz = Quiz.find(params[:id])
    @responses = Response.where(quiz_id: @quiz.id, student_id: current_user.id)
  end

  # GET '/quizzes/new'
  def new
    @quiz = Quiz.new
    @question = @quiz.questions.build
    @answer = @question.answers.build
    @quiz_questions = Question.all
  end

  # method so only one checkbox can be checked
  # when a checkbox is checked for correct answer, that should call on the correct_answer method defined in question.rb

  # POST '/quizzes'
  def create
    @quiz = Quiz.new(test_day: params[:test_day], instructor_id: params[:instructor_id], cohort_id: params[:cohort_id])
    @question = Question.new(content: params[:content], quiz_id: @quiz.id)
    @answer = Answer.new(choice: params[:choice], question_id: @question.id, is_correct: params[:is_correct])
    if @quiz.save
      redirect_to '/quizzes'
    else
      render :new
    end
  end

end
