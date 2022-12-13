class UsersController < ApplicationController

	def index
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.update(status:"pending")
			redirect_to root_path, notice:"Application submitted and please wait for admin response on email."
		else
			render :index
		end
	end

	private

	def user_params
		params.permit(:email, :password, :first_name, :last_name)
	end
end
