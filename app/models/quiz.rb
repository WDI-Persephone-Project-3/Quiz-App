class Quiz < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :cohort
  has_many :responses
  has_and_belongs_to_many :questions

end