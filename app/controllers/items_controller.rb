class ItemsController < ApplicationController
	before_action :find_item, only: [:show,:edit,:update,:destroy]
	def index
		if user_signed_in?
			if params[:complete]
				@items = Item.where(:user_id => current_user.id).where(:status => params[:complete]).order("created_at DESC")
			else
				@items = Item.where(:user_id => current_user.id).order("created_at DESC")
			end
		end
	end

	def show
		
	end

	def new
		@item = current_user.items.build
	end

	def create
		@item = current_user.items.build(item_params)

		if @item.save
			redirect_to root_path
		else
			render 'new'
		end
		
	end

	def edit
		
	end

	def update

		if @item.update(item_params)
			
			redirect_to item_path(@item)
		else
			render "edit"
		end
	end

	def destroy
		@item.destroy

		redirect_to root_path
	end


	def complete
		@item = Item.find(params[:id])
		if @item.completed_at == nil
			@item.update_attribute(:completed_at,Time.now)
			@item.update_attribute(:status,true)
		else
			@item.update_attribute(:completed_at,nil)
			@item.update_attribute(:status,false)
		end
		redirect_to root_path
	end

	protected
		def item_params
			params.require(:item).permit(:title,:description)
		end

		def find_item
			@item = Item.find(params[:id])
		end
end
