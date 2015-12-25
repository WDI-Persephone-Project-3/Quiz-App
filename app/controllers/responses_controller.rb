class ResponsesController < ApplicationController

  def create
    @quiz = Quiz.find(params[:id])
    i = 1

    # Questions have the params Q-number and choices have the params number. This weird 2*i logic accounts that for every question, there is a choice param and a question param. The extra 5 params are unimportant to choice selection
    while (2*i)<(params.length-5)
      question_id = params["Q"+i.to_s]
      Response.create(choice: params[question_id], student_id: current_user.id, quiz_id: params[:id], question_id: question_id)
      i += 1
    end
    binding.pry
    redirect_to @quiz
  end

end
