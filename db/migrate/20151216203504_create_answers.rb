class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :choice
      t.references :question
      t.boolean :is_correct
    end
  end
end
