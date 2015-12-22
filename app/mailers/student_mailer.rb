class StudentMailer < ApplicationMailer
  default from: 'instructor@email.com'
  layout 'mailer'

  def welcome_email(student)
    @student = student
    # @url = '/'
    mail(to: @student.email, subject: 'Welcome to Quizapp')
  end

  def quiz_results_email(student)
    @student = student
    @url = '/students/dash'
    mail(to: @student.email, subject:'Your Quiz Results').deliver()
  end

end