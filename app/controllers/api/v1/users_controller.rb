module Api::V1
  class UsersController < BaseController
    before_action :set_me, only:[:me, :logout, :show, :update, :destroy, :password_update]


    def show
      json_response(@user)
    end

    def update
      @user.update(user_params)
      json_response(@user, :updated)
    end

    def destroy
      @user.destroy
      head :no_content
    end

    def me
      res = {
        id: request.headers[:X_WWW_USER_TOKEN]
      }
      json_response(res)
    end

    def logout
    	@user.update_attribute(:token, nil)
      if @user.has_role? :driver
        @user.taxis.update({:ocupado => false})
      end
    	json_response(@user)
    end

    def password_update
      @user.password_update(password_update_params)
      json_response(@user, :updated)
    end


    private

    def user_params
      params.permit(:api_token, :github, :date_format, :beginning_of_week, :language)
    end

    def password_update_params
      params.permit(:contrasenia_antigua, :contrasenia_nueva, :confirmacion_contrasenia_nueva)
    end


    def set_me
    	@user = User.find_by(token: request.headers[:HTTP_USER_TOKEN]) 
    end
  end
end
