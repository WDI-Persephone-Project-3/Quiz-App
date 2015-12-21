require 'test_helper'

class StudentMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end

  # excerpt from ruby guides <----
  # send email
  # store returned object in email variable
  # ensure that it was sent (the first assert)
  # in the second batch of assertions, ensure that the email does indeed contain what we expect
  # helper read_fixture is used to read in the content from this file.
  #  ---->
  test "welcome" do
    @instructor = Instructor.find(params[:id])
    @student = Student.find(params[:id])
    email = StudentMailer.welcome(@instructor.email, @student.email, Time.now).deliver_now
    
    assert_not ActionMailer::Base.deliveries.empty?
    
    assert_equal [@instructor.email], email.from
    assert_equal [@student.email], email.to
    assert_equal 'Welcome to Quizapp', email.subject
    assert_equal read_fixture('welcome').join, email.body.to_s
  end
end
