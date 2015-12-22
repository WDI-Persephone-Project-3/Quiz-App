class ResponsesController < ApplicationController

  def create
    @quiz = Quiz.find(params[:id])
    i = 1
    while i<(params.length-5)
      Response.create(choice: params[i.to_s], student_id: current_user.id, quiz_id: params[:id], question_id: i)
      i += 1
    end
    redirect_to @quiz
  end

end
