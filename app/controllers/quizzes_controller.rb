class QuizzesController < ApplicationController

  # GET '/quizzes'
  def index
    @quizzes = Quiz.where(instructor_id: current_user.id).order(test_day: :desc) if current_user.class == Instructor
    @quizzes = Quiz.where(cohort_id: Student.find(current_user.id).cohort_id).order(test_day: :desc) if current_user.class == Student
  end

  # GET '/quizzes/1'
  def show
    @quiz = Quiz.find(params[:id])
    @responses = Response.where(quiz_id: @quiz.id, student_id: current_user.id)
  end

  # GET '/quizzes/new'
  def new
    @quiz = Quiz.create
    @question = @quiz.questions.build
    @answer = @question.answers.build
    @quiz_questions = Question.all
  end

  # method so only one checkbox can be checked
  # when a checkbox is checked for correct answer, that should call on the correct_answer method defined in question.rb

  # POST '/quizzes'
  def create
    @quiz_questions = Question.all    
    @quiz = Quiz.last  
    @quiz.update(test_day: params[:test_day], instructor: current_user, cohort: Cohort.find_by(instructor: current_user))
    # @question = Question.new(content: params[:content])
    @answer = Answer.new(choice: params[:answer], question_id: Question.find_by(content: params[:content]).id, is_correct: params[:is_correct])
      if params[:commit] == "Add Question"
        @created_quiz = Quiz.find(@quiz.id)
        @created_quiz.questions.push(Question.find_by(content: params[:content]))
        @created_quiz.save
        render :new
      elsif params[:commit] == "Submit Quiz"
        @created_quiz = Quiz.find(@quiz.id)
        @created_quiz.questions.push(Question.find_by(content: params[:content]))
        @created_quiz.save
        binding.pry
        redirect_to "/quizzes"
      end
  end

  def quiz
    @todaysQuiz = Quiz.find_by(test_day: Date.today, cohort: current_user.cohort) if current_user
    if current_user.class == Student && @todaysQuiz
      redirect_to "/quizzes/#{@todaysQuiz.id}"
    else
      redirect_to "/"
    end 
  end

end
