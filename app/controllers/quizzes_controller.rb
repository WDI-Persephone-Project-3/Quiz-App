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
    redirect_to "/" if current_user.class != Instructor
    @quiz = Quiz.create
    @question = @quiz.questions.build
    @answer = @question.answers.build
    @quiz_questions = Question.all
  end

  # method so only one checkbox can be checked
  # when a checkbox is checked for correct answer, that should call on the correct_answer method defined in question.rb

  # POST '/quizzes'
  def create
    @test_day = params[:test_day] if params[:test_day]
    @quiz_questions = Question.all    
    @quiz = Quiz.last
    @current_questions = @quiz.questions if @quiz.questions  
    @quiz.update(test_day: params[:test_day], instructor: current_user, cohort: Cohort.find_by(instructor: current_user))
    # @answer = Answer.new(choice: params[:answer], question_id: Question.find_by(content: params[:content]).id, is_correct: params[:is_correct])
    @created_quiz = Quiz.find(@quiz.id)
    if params[:written_content].length==0
      @created_quiz.questions.push(Question.find_by(content: params[:content]))
    else
      question = Question.create(content: params[:written_content])
      @created_quiz.questions.push(question)
      Answer.create(question: question, choice: params[:choice1], is_correct: false)
      Answer.create(question: question, choice: params[:choice2], is_correct: false)
      Answer.create(question: question, choice: params[:choice3], is_correct: false)
      Answer.create(question: question, choice: params[:choice4], is_correct: false)
      Answer.where(question: question)[params[:is_correct].to_i].update(is_correct: true)
    end

    @created_quiz.save
    if params[:commit] == "Add Question"
      render :new
    elsif params[:commit] == "Submit Quiz"
    # @created_quiz = Quiz.find(@quiz.id)
    # @created_quiz.questions.push(Question.find_by(content: params[:content]))
    # @created_quiz.save
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
