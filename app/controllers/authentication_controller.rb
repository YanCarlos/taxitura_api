class AuthenticationController < ApplicationController
  before_action :set_user, only: [:autenthicate_user, :logout_user]

  def autenthicate_user
    if @user and @user.authenticate params[:password] 
      if @user.has_role? :driver
        return error_taxi unless @user.taxi_avalaible?
      end

      if !@user.generate_token
        acceso_denegado
      end

      res = {
        id: @user.id,
        nombre: @user.nombre,
        cedula: @user.cedula,
        telefono: @user.telefono,
        direccion: @user.direccion,
        email: @user.email,
        activo: @user.activo, 
        token: @user.token,
        role: @user.roles[0].name,
        created_at: @user.created_at,
        updated_at: @user.updated_at,
        foto: @user.the_user_photo,
        credito: @user.credito,
        credito_ganancia: @user.credito_ganancia,
        taxis: @user.taxis
      }

      render json: res, status: 200
    else
      acceso_denegado
    end 
  end

  def logout_user
    if @user && @user.reset_token
      render json: @user, status: 200
    else
      acceso_denegado
    end
  end

  private
  def auth_params
    params.permit(:user, :password, :token)
  end

  def set_user
    @user = (User.find_by(email: params[:user]) || User.find_by(cedula: params[:user])) ||
            User.find_by(token: params[:token])
  end


  def acceso_denegado
    res = {
      message: 'acceso_denegado'
    }
    render json: res, status: 401
  end

  def error_taxi
    res = {
      message: 'Por favor verifique que el taxi asignado no se encuentre ocupado'
    }
    render json: res, status: 401
  end

end
