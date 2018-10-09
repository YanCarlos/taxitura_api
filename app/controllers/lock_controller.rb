class LockController < ApplicationController
	helper_method :is_home?
	before_action :is_user_authenticated?
	
	private
	def is_user_authenticated?
		redirect_to sign_in_path	 unless current_user || is_home?
	end

	def is_home?
		controller_name == 'home'
	end

	def is_sign_in?
		is_sign_in? == 'sign_in'
	end
end
