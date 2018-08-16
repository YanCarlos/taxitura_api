class UsersController < ApplicationController
	before_action :set_user, only: [:new_session, :logout_user]
	skip_before_action :is_user_authenticated?, :only => [:sign_in, :new_session]

	def sign_in
		redirect_to taxis_path if current_user
	end

	def new_session
		if @user and @user.authenticate params[:password]
			session[:user] = @user
			redirect_to taxis_path
		else
			flash[:error] = 'Usuario o contraseña incorrecta.'
			render :sign_in
		end
		
	end

	def logout_user
		if current_user.reset_token
			session.delete(:user)
		end
		redirect_to sign_in_path
	end

	private
		def set_user
	    @user = (User.find_by(email: params[:user]) || User.find_by(cedula: params[:user])) ||
	            User.find_by(token: params[:token])
	  end
	
end
