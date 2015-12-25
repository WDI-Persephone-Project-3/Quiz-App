class QuizzesController < ApplicationController

  # GET '/quizzes'
  def index
    @quizzes = Quiz.where(instructor_id: current_user.id).order(test_day: :desc) if current_user.class == Instructor
    @quizzes = Quiz.where(cohort_id: Student.find(current_user.id).cohort_id).order(test_day: :desc) if current_user.class == Student
  end

  # GET '/quizzes/1'
  def show
    @quiz = Quiz.find(params[:id])
    # Students should only be able to access quizzes in their cohort with test days no later than current day
    if current_user.class == Student
      # Return quiz ids for student's cohort, such that none have test days later than current day
      all_quizzes_for_cohort = Quiz.where(cohort: current_user.cohort).map do |quiz|
        if quiz.test_day <= Date.today
          quiz.id
        end
      end
      # If accessed quiz is not in array of allowed quizzes, redirect to dashboard
      if !all_quizzes_for_cohort.index(params[:id].to_i)
        redirect_to "/"
      else      
        @responses = Response.where(quiz_id: @quiz.id, student_id: current_user.id)
      end
    end
  end

  # GET '/quizzes/new'
  def new
    # Students cannot make quizzes
    redirect_to "/" if current_user.class != Instructor
    @quiz = Quiz.create(instructor: current_user)
    @quiz_questions = Question.all
    @cohorts = Cohort.where(instructor: current_user)
  end

  # POST '/quizzes'
  def create
    # Carry over test_day when specified
    @test_day = params[:test_day] if params[:test_day]
    @cohorts = Cohort.where(instructor: current_user)
    @quiz_questions = Question.all
    # Grab the latest quiz created by the current_user (created in NEW)
    @quiz = Quiz.where(instructor: current_user).last
    # Grab any questions that were added to the quiz
    @current_questions = @quiz.questions if @quiz.questions
    @quiz.update(test_day: params[:test_day], cohort: Cohort.find_by(name: params[:cohort]))
    # If user wants to add a question, it renders the form again allowing them to push more questions to the same quiz
    if params[:commit] == "Add Question"
      # If there is no written question, add the question in the drop-down menu
      if params[:written_content].length==0
        @quiz.questions.push(Question.find_by(content: params[:content]))
      # Else create the written question, the written answers, and give one of the answers
      else
        question = Question.create(content: params[:written_content])
        @created_quiz.questions.push(question)
        Answer.create(question: question, choice: params[:choice1], is_correct: false)
        Answer.create(question: question, choice: params[:choice2], is_correct: false)
        Answer.create(question: question, choice: params[:choice3], is_correct: false)
        Answer.create(question: question, choice: params[:choice4], is_correct: false)
        Answer.where(question: question)[params[:is_correct].to_i].update(is_correct: true)
      end      
      render :new
    # Else the quiz is complete
    else
      if params[:test_day].length == 0
        render :new
      else
        redirect_to "/quizzes/#{@quiz.id}"
      end
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
