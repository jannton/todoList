require 'rails_helper'
require 'spec_helper'

RSpec.describe TasksController, :type => :controller do


	describe "GET index" do
		it "returns home page" do
			get 'index'
			expect(response).to be_success
		end
	end

	describe 'POST create' do 
		it "route POST /tasks to tasks#create" do
			expect(post: '/tasks').to route_to('tasks#create')
		end
	end


	describe 'GET new' do 
		it "route GET /tasks to tasks#new" do
			expect(get: '/tasks/new').to route_to('tasks#new')
		end
	end

	describe "PUT complete" do
		it "updates boolean values" do 
			expect(put: '/tasks/completed').to route_to('tasks#completed')
		end
	end
	

end
