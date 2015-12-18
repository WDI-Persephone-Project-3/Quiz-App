class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.date :test_day
      t.references :instructor
      t.references :cohort
    end
  end
end
