class CohortsController < ApplicationController
	
	def index
		@instructor = Instructor.find(params[:id])
		@cohorts = Cohort.find_by(instructor_id params[@instructor])
	end

	def show
		@instructor = Instructor.find(params[:id])
		@cohorts = Cohort.find_by(instructor_id params[@instructor])
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
