require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "welcome student" do
    # @student = Student.find(params[:id])
    # @instructor = Instructor.find(params[:id])
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :welcome_student, email: "diekilgrave@gmail.com"
    end
    welcome_email = ActionMailer::Base.deliveries.last

    assert_equal "You have been invited by ona.quizapp@gmail.com", welcome_email.subject
    assert_equal 'diekilgrave@gmail.com', welcome_email.to[0]
    assert_match(/Hi diekilgrave@gmail.com/, welcome_email.body.to_s) 
  end
end
