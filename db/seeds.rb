i1 = Instructor.create({last_name: "Pak", first_name: "Suhyun", email: "suhyun@quizapp.com", password: "123", password_confirmation: "123"})
i2 = Instructor.create({last_name: "Olagundoye", first_name: "De", email: "de@quizapp.com", password: "123", password_confirmation: "123"})
i3 = Instructor.create({last_name: "Kolchinskiy", first_name: "Sergey", email: "sergey@quizapp.com", password: "123", password_confirmation: "123"})
i4 = Instructor.create({last_name: "Boseroy", first_name: "Ona", email: "ona.quizapp@gmail.com", password: "p@55w0rd12", password_confirmation: "p@55w0rd12"})
i5 = Instructor.create({last_name: "Gandikota", first_name: "Anusha", email: "anusha@quizapp.com", password: "123", password_confirmation: "123"})


c1 = Cohort.create({name: "Wolverine", instructor: i1})
c2 = Cohort.create({name: "Prof X", instructor: i3})
c3 = Cohort.create({name: "Storm", instructor: i2})
c4 = Cohort.create({name: "Wonder Woman", instructor: i4})
c5 = Cohort.create({name: "Cat Woman", instructor: i5})
c6 = Cohort.create({name: "Test", instructor: i3})

s1 = Student.create({last_name: "Wayne", first_name: "John", email: "johnwayne@gmail.com", password: "123", password_confirmation: "123", cohort: c1})
s2 = Student.create({last_name: "Kent", first_name: "Clarke", email: "notsuperman@gmail.com", password: "123", password_confirmation: "123", cohort: c6})
s3 = Student.create({last_name: "BeGood", first_name: "Johnny", email: "goodygoody@gmail.com", password: "123", password_confirmation: "123", cohort: c3})
s4 = Student.create({last_name: "Stallone", first_name: "Sylvester", email: "rocky@gmail.com", password: "123", password_confirmation: "123", cohort: c4})
s5 = Student.create({last_name: "McFly", first_name: "Martin", email: "biffsucks@gmail.com", password: "123", password_confirmation: "123", cohort: c5})
s6 = Student.create({last_name: "Gump", first_name: "Forrest", email: "run4estrun@gmail.com", password: "123", password_confirmation: "123", cohort: c6})
s7 = Student.create({last_name: "Smith", first_name: "Will", email: "welcomeToEarth@gmail.com", password: "123", password_confirmation: "123", cohort: c3})
s8 = Student.create({last_name: "Soze", first_name: "Keyser", email: "whoiskeyser@gmail.com", password: "123", password_confirmation: "123", cohort: c1})
s9 = Student.create({last_name: "Ripley", first_name: "Ellen", email: "alienz@gmail.com", password: "123", password_confirmation: "123", cohort: c4})
s10 = Student.create({last_name: "Connor", first_name: "Sarah", email: "xoxoT800xoxo@gmail.com", password: "123", password_confirmation: "123", cohort: c5})
s11 = Student.create({last_name: "Thurman", first_name: "Uma", email: "ikillbill@gmail.com", password: "123", password_confirmation: "123", cohort: c1})
s12 = Student.create({last_name: "Macguff", first_name: "Juno", email: "impregnant@gmail.com", password: "123", password_confirmation: "123", cohort: c6})
s13 = Student.create({last_name: "Ventura", first_name: "Ace", email: "petdetective@gmail.com", password: "123", password_confirmation: "123", cohort: c6})
s14 = Student.create({last_name: "Summers", first_name: "Scott", email: "cyclops@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s15 = Student.create({last_name: "Wagner", first_name: "Kurt", email: "nightcrawler@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s16 = Student.create({last_name: "Grey", first_name: "Jean", email: "phoenix@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s17 = Student.create({last_name: "Drake", first_name: "Bobby", email: "iceman@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s18 = Student.create({last_name: "McCoy", first_name: "Hank", email: "beast@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s19 = Student.create({last_name: "Pryde", first_name: "Kitty", email: "shadowcat@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s20 = Student.create({last_name: "Worthington", first_name: "Warren", email: "angel@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s21 = Student.create({last_name: "Lee", first_name: "Jubilation", email: "jubilee@gmail.com", password: "123", password_confirmation: "123", cohort: c2})
s22 = Student.create({last_name: "Jones", first_name: "Jessica", email: "diekilgrave@gmail.com", password: "Sup3rd00per", password_confirmation: "Sup3rd00per", cohort: c4})

q1 = Question.create({content: "1 + 1"})
q2 = Question.create({content: "1 + 2"})
q3 = Question.create({content: "1 + 3"})
q4 = Question.create({content: "2 + 2"})
q5 = Question.create({content: "2 + 3"})
q6 = Question.create({content: "2 + 4"})
q7 = Question.create({content: "3 + 3"})
q8 = Question.create({content: "3 + 4"})
q9 = Question.create({content: "4 + 4"})
q10 = Question.create({content: "4 + 5"})

a1 = Answer.create({choice: "2", question: q1, is_correct: true})
a2 = Answer.create({choice: "1", question: q1, is_correct: false})
a3 = Answer.create({choice: "4", question: q1, is_correct: false})
a4 = Answer.create({choice: "3", question: q1, is_correct: false})


a5 = Answer.create({choice: "1", question: q2, is_correct: false})
a6 = Answer.create({choice: "4", question: q2, is_correct: false})
a7 = Answer.create({choice: "2", question: q2, is_correct: false})
a8 = Answer.create({choice: "3", question: q2, is_correct: true})

a9 = Answer.create({choice: "4", question: q3, is_correct: true})
a10 = Answer.create({choice: "2", question: q3, is_correct: false})
a11 = Answer.create({choice: "3", question: q3, is_correct: false})
a12 = Answer.create({choice: "1", question: q3, is_correct: false})

a13 = Answer.create({choice: "2", question: q4, is_correct: false})
a14 = Answer.create({choice: "4", question: q4, is_correct: true})
a15 = Answer.create({choice: "3", question: q4, is_correct: false})
a16 = Answer.create({choice: "5", question: q4, is_correct: false})

a17 = Answer.create({choice: "5", question: q5, is_correct: true})
a18 = Answer.create({choice: "3", question: q5, is_correct: false})
a19 = Answer.create({choice: "4", question: q5, is_correct: false})
a20 = Answer.create({choice: "6", question: q5, is_correct: false})

a21 = Answer.create({choice: "4", question: q6, is_correct: false})
a22 = Answer.create({choice: "3", question: q6, is_correct: false})
a23 = Answer.create({choice: "6", question: q6, is_correct: true})
a24 = Answer.create({choice: "5", question: q6, is_correct: false})

a25 = Answer.create({choice: "5", question: q7, is_correct: false})
a26 = Answer.create({choice: "4", question: q7, is_correct: false})
a27 = Answer.create({choice: "6", question: q7, is_correct: true})
a28 = Answer.create({choice: "7", question: q7, is_correct: false})

a29 = Answer.create({choice: "7", question: q8, is_correct: true})
a30 = Answer.create({choice: "5", question: q8, is_correct: false})
a31 = Answer.create({choice: "4", question: q8, is_correct: false})
a32 = Answer.create({choice: "6", question: q8, is_correct: false})

a33 = Answer.create({choice: "7", question: q9, is_correct: false})
a34 = Answer.create({choice: "6", question: q9, is_correct: false})
a35 = Answer.create({choice: "9", question: q9, is_correct: false})
a36 = Answer.create({choice: "8", question: q9, is_correct: true})

a37 = Answer.create({choice: "9", question: q10, is_correct: true})
a38 = Answer.create({choice: "8", question: q10, is_correct: false})
a39 = Answer.create({choice: "10", question: q10, is_correct: false})
a40 = Answer.create({choice: "7", question: q10, is_correct: false})

test_quiz1 = Quiz.create({test_day: Date.today, instructor: Instructor.first, cohort: c1})
test_quiz2 = Quiz.create({test_day: Date.parse('11th Dec 2015'), instructor: i3, cohort: c2})
test_quiz2 = Quiz.create({test_day: Date.parse('12th Dec 2015'), instructor: i3, cohort: c2})
test_quiz2 = Quiz.create({test_day: Date.parse('13th Dec 2015'), instructor: i3, cohort: c6})
test_quiz2 = Quiz.create({test_day: Date.parse('14th Dec 2015'), instructor: i3, cohort: c6})
test_quiz2 = Quiz.create({test_day: Date.parse('15th Dec 2015'), instructor: i3, cohort: c2})
test_quiz2 = Quiz.create({test_day: Date.parse('16th Dec 2015'), instructor: i3, cohort: c2})
test_quiz2 = Quiz.create({test_day: Date.parse('17th Dec 2015'), instructor: i3, cohort: c2})
test_quiz2 = Quiz.create({test_day: Date.parse('18th Dec 2015'), instructor: i3, cohort: c2})
test_quiz2 = Quiz.create({test_day: Date.today, instructor: i3, cohort: c2})

test_quiz3 = Quiz.create({test_day: Date.parse('19th Dec 2015'), instructor: i3, cohort: c2})
test_quiz4 = Quiz.create({test_day: Date.parse('10th Dec 2015'), instructor: i3, cohort: c2})
test_quiz5 = Quiz.create({test_day: Date.parse('9th Dec 2015'), instructor: i3, cohort: c2})
test_quiz6 = Quiz.create({test_day: Date.parse('8th Dec 2015'), instructor: i3, cohort: c2})
test_quiz7 = Quiz.create({test_day: Date.parse('7th Dec 2015'), instructor: i3, cohort: c2})
test_quiz8 = Quiz.create({test_day: Date.parse('6th Dec 2015'), instructor: i3, cohort: c2})
test_quiz9 = Quiz.create({test_day: Date.parse('5th Dec 2015'), instructor: i3, cohort: c2})
test_quiz10 = Quiz.create({test_day: Date.parse('4th Dec 2015'), instructor: i3, cohort: c2})
test_quiz11 = Quiz.create({test_day: Date.parse('3th Dec 2015'), instructor: i3, cohort: c2})

Quiz.all.each do |quiz|
  Question.all.each do |question|
  quiz.questions.push(question)
  end
end

Cohort.all.each do |cohort|
  Student.where(cohort: cohort).each do |student|
    Quiz.where(cohort: cohort).each do |quiz|
      quiz.questions.each do |question|
        randomAnswer = Answer.where(question: question).offset(rand(4)).first
        Response.create(choice: randomAnswer.choice, student: student, quiz: quiz, question: question)
      end
    end
  end
end