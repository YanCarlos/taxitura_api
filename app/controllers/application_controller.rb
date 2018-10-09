class ApplicationController < ActionController::Base
	helper_method :current_user

	def current_user
		return nil if session[:user].nil?
		User.find(session[:user].id)
	end
end
