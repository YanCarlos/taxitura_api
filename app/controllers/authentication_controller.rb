class AuthenticationController < ApplicationController
  before_action :set_user, only: [:autenthicate_user, :logout_user]

  def autenthicate_user
    if @user and @user.authenticate params[:password] 
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
        foto: @user.foto,
        credito: @user.credito,
        credito_ganancia: @user.credito_ganancia,
        taxis: @user.taxis
      }

      if @user.has_role? :driver
        @user.validate_taxi
      end

      if !@user.generate_token
        acceso_denegado
      end

      render json: res, status: 200
    else
      acceso_denegado
    end 
  end

  def logout_user
    if @user and @user.reset_token
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

end
