class CohortsController < ApplicationController
	
	# def index
	# 	@cohorts = Cohort.all
	# end

	def show
		@c1 = Cohort.find(params[:id])
		@students = @c1.cohorts.students
	end

	def new 
	end

	def edit
	end

	def create
	end

	def destroy
	end

	def update
	end

end
