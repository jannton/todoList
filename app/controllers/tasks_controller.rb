class TasksController < ApplicationController
  
  #display all tasks in table 
  def index
  	#@tasks = Task.all
  	@task = Task.new

  	#creating instance that contains tasks attribute with null value"
  	@incomplete_tasks = Task.where(:checked => false)
  	@completed_tasks = Task.where(:checked => true)
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
  		flash[:notice] = 'Successfully added new task.'
  		#if it is able to save the task bc it passes the validation
  		#redirect home page
  		redirect_to root_path
  	else
  		flash[:notice] = 'Unable to add task!'
  		#if we are unable to save the task bc it fails the validation then
  		#go back to home page with task form
  		redirect_to :back
  	end
  end
  #*******END*******#

  #*******START*******#
  def update
  	#look for that specific object to update with that :id
  	@task = Task.find(params[:id])

  	#it is able to update
  	if @task.update(task_params)
  		flash[:notice] = 'Successfully updated task.'
  		#if it is able to update the task object bc it passes the validation
  		#redirect home page
  		redirect_to root_path
  	else
  		flash[:notice] = 'Unable to edit task!'
  		#if we are unable to update the task bc it fails the validation then
  		#go back to home page with task form
  		redirect_to :back
  	end
  end
  #*******END*******#

  def destroy
  	#look for that specific object to update with that :id
  	@task = Task.find(params[:id])
  	#destroy the task/resource
  	@task.destroy
  	flash[:notice] = 'Successfully deleted task.'

  	#redirect to index (the prefix name + _path)
  	redirect_to tasks_path
  end


  def completed
    #find all tasks that are in the task_ids array and update their checked boolean to true
    #can see activity in development log if need be to see what tasks(by id) is in the selected array
  	Task.where( :id => params[:task_ids] ).update_all( :checked => true )
  	flash[:notice] = 'Successfully completed tasks.'
  	redirect_to tasks_path
  end 


  #this prevents injection into parameters, also this needs to be at the bottom or it will cause null error
  #since its private it will have conflict with other methods if its above them
  private
  	def task_params
  		params.require(:task).permit(:task_name, :description, :category, :due_date)
  	end
  
end
