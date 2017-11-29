class InboxesController < ApplicationController

  def create
    @inbox = Inbox.new(inbox_params)
    if @inbox.save
      flash[:success] = "#{@inbox.nombre}, tu mensaje se ha enviado correctamente, pronto nos comunicaremos contigo."
    else
      flash[:error] = "Hubo un error al enviar tu mensaje, intenta nuevamente."
    end
    redirect_to '#CONTACT'
  end

  private
  def inbox_params
    params.require(:inbox).permit(:nombre, :email, :asunto, :mensaje)
  end
end
