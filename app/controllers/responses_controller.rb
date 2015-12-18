class ResponsesController < ApplicationController

  def create
    i = 1
    while i<(params.length-5)
      Response.create(choice: params[i.to_s], student_id: current_user.id, quiz_id: params[:id], question_id: i)
      i += 1
    end
    # @params = params
    redirect_to '/quizzes'
  end

end
