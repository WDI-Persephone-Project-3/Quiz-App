class CohortsController < ApplicationController

	def show
		@cohort = Cohort.find(params[:id])
		@students = Student.where(cohort_id: @cohort).order("last_name")
	end

	def new 
		@cohorts = Cohort.new
	end

	def edit
	end

	def create
		@cohort = Cohort.create(name params[:name], instructor_id)
	end

	def destroy
	end

	def update
	end

end
