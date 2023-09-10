class TodoListsController < ApplicationController
	def index
		@todo_lists = TodoList.all
		@todo_list = TodoList.new
		count_todos
	end

	def create
		@todo_list = TodoList.new(todo_list_params)

		if @todo_list.save
			TodoList.where(completed: nil).update(completed: false)
			redirect_to root_path
		else
			render :index, status: :unprocessable_entity
		end
	end

	def edit
		@todo_list = TodoList.find(params[:id])
		@todo_lists = TodoList.all
		count_todos
	end

	def update
		@todo_list = TodoList.find(params[:id])
		
		if @todo_list.update(todo_list_params)
			redirect_to root_path
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@todo_list = TodoList.find(params[:id])
		@todo_list.destroy

		redirect_to root_path
	end

	private
	def todo_list_params
		params.require(:todo_list).permit(:content, :completed)
	end

	def count_todos
		@count_all = TodoList.where(completed: false).count | TodoList.where(completed: true).count
		@count_active = TodoList.where(completed: false).count
		@count_completed = TodoList.where(completed: true).count
	end
end
