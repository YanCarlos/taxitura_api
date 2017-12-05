module Api::V1
  class BaseController < ApplicationController
    include Concerns::Response
    include Concerns::ExceptionHandler

    before_action :is_user_authenticated?

    helper_method :current_user 
    
    def is_user_authenticated?
      return true if authenticate_token
      render json: { errors: [ { detail: 'Access denied' } ] }, status: 401
    end

    def current_user
      authenticate_token
    end

    private
    def authenticate_token
      return nil if request.headers[:HTTP_USER_TOKEN].nil?
      User.find_by(token: (request.headers[:HTTP_USER_TOKEN]))
    end

  end
end
