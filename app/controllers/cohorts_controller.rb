class CohortsController < ApplicationController
	
	def index
		@cohorts = Cohort.all.order("name")
	end

	def show
		@cohort = Cohort.find(params[:id])
		@students = Student.where(cohort_id: @cohort).order("last_name")
	end

	def new 
		@cohort = Cohort.new
	end

	def edit
	end

	def create
		@cohort = Cohort.create(name: params[:name], instructor_id: session[:user_id])
		redirect_to '/cohorts'
	end

	def destroy
	end

	def update
	end

end
