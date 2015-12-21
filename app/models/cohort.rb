class Cohort < ActiveRecord::Base
  belongs_to :instructor
  has_many :students

  def cohort_average
    students = self.students
    all_students_avg = students.map do |student|
      student.current_average
    end
    students_avg_total = all_students_avg.reduce(:+)
    cohort_avg = students_avg_total.to_f / students.length.to_f
  end
end