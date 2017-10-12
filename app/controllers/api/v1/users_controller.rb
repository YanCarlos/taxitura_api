module Api::V1
  class UsersController < BaseController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :set_me, only:[:me, :logout]

    def index
      @users = User.all
      json_response(@users, @users.count)
    end

    def show
      json_response(@user)
    end

    def update
      @user.update(user_params)
      json_response(@user)
    end

    def destroy
      @user.destroy
      head :no_content
    end

    def me
      json_response(@user)
    end

    def logout
    	@user.update_attribute(:token, nil)
    	json_response(@user)
    end

    private

    def user_params
      params.permit(:api_token, :github, :date_format, :beginning_of_week, :language)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_me
    	@user = User.find_by(token: request.headers[:HTTP_USER_TOKEN])
    end
  end
end
