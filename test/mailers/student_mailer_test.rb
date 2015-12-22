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
    email = StudentMailer.welcome('ona.quizapp@gmail.com', 'diekilgrave@gmail.com', Time.now).deliver_now
    
    assert_not ActionMailer::Base.deliveries.empty?
    
    assert_equal ['ona.quizapp@gmail.com'], email.from
    assert_equal ['diekilgrave@gmail.com'], email.to
    assert_equal 'Welcome to Quizapp', email.subject
    assert_equal read_fixture('welcome').join, email.body.to_s
  end
end
