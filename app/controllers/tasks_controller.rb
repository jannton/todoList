class TasksController < ApplicationController
  
  #display all tasks in table 
  def index
  	#@tasks = Task.all

  	#creating instance that contains tasks attribute with null value"
  	@incomplete_tasks = Task.where("completed_at IS NULL")
  	#creating instance that contains tasks attribute with NOT null value"
  	@completed_tasks = Task.where("completed_at IS NOT NULL")
  end

  #(:id) tells rails this expects an id of the task in the parameter 
  def show 
  	@task = Task.find(params[:id])
  end

  #creating a new task
  def new
  	@task = Task.new
  end


  #edit that specific task/object
  def edit
  	@task = Task.find(params[:id])
  end

  #*******START*******#
  def create
  	@task = Task.new(task_params)

  	#it is able to save a new task 
  	if @task.save
  		flash[:notice] = 'Successfully added new task!'
  		#if it is able to save the task bc it passes the validation
  		#redirect to the specific record with an id
  		#which is pretty much 'show' or tasks#show it 
  		redirect_to @task
  	else
  		#if we are unable to save the task bc it fails the validation then
  		#render the same request form 
  		render "new"
  	end
  end
  #*******END*******#

  #*******START*******#
  def update
  	#look for that specific object to update with that :id
  	@task = Task.find(params[:id])

  	#it is able to update
  	if @task.update(task_params)
  		flash[:notice] = 'Successfully updated task!'
  		#if it is able to update the task object bc it passes the validation
  		#redirect to the specific record with an id
  		#which is pretty much 'show' or tasks#show it 
  		redirect_to @task
  	else
  		#if we are unable to update the task bc it fails the validation then
  		#render the same request form 
  		render 'edit'
  	end
  end
  #*******END*******#

  def destroy
  	#look for that specific object to update with that :id
  	@task = Task.find(params[:id])
  	#destroy the task/resource
  	@task.destroy
  	flash[:notice] = 'Successfully deleted task!'

  	#redirect to index (the prefix name + _path)
  	redirect_to tasks_path
  end

  def complete
  	@task = Task.find(params[:id])
  	@task.update_attribute :completed_at, Time.now
  	flash[:notice] = "Marked task as completed!!"
  	redirect_to completed_tasks_path
  end 


  #this prevents injection into parameters, also this needs to be at the bottom or it will cause null error
  #since its private it will have conflict with other methods if its above them
  private
  	def task_params
  		params.require(:task).permit(:task_name, :description, :category, :due_date)
  	end
  
end
