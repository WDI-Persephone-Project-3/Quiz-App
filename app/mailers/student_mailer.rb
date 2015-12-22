class StudentMailer < ApplicationMailer
  default from: 'ona.quizapp@gmail.com'
  layout 'mailer'

  def welcome_email(student)
    @student = student
    @url = '/login'
    mail(to: @student.email, subject: 'Welcome to Quizapp')
  end

  def quiz_results_email(student)
    @student = student
    @url = '/students/dash'
    mail(to: @student.email, subject:'Your Quiz Results').deliver()
  end

end

# references for later, when we want to make sure the username and password in testing can't be accessed.
# http://usingname.space/2015/07/25/gmail-smtp-ruby-on-rails-actionmailer-and-you/
# https://github.com/laserlemon/figaro
# http://railsapps.github.io/rails-environment-variables.html
