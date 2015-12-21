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

  def cohort_mode
  	students = self.students
  	all_students_avg = students.map do |student|
      student.current_average
    end
    all_students_avg.group_by(&:itself).values.max_by(&:size).first #method to find mode found on stackoverflow
  end

  def cohort_median
  	students = self.students
    all_students_avg = students.map do |student|
      student.current_average
    end
    middle = all_students_avg.length / 2
    median = all_students_avg[middle]
  end

end