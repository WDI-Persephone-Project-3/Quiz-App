class CohortsController < ApplicationController
	
	def index
		@instructor = Instructor.find(params[:id])
		@cohorts = Cohort.find_by(instructor_id: params[@instructor])
	end

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
		@cohorts = Cohort.create(name: params[:name], instructor_id: session[:user_id])
	end

	def destroy
	end

	def update
	end

end
