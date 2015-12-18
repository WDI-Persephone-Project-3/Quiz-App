class AnswersController < ApplicationController

  def show
    @quiz = Quiz.find(params [:id])
    @quiz_questions = @quiz.questions
  end

end
