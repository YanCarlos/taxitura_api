class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:create]

  def create
    if @subscriber
      flash[:success_subs] = 'Ya estas suscrito a nuestro boletín informativo.'
    else
      @subscriber = Subscriber.new(subscriber_params)
      if @subscriber.save and Subscribers.add_subscriber @subscriber.email
        flash[:success_subs] = 'Te has suscrito a nuestro boletín informativo de manera exitosa.'
      else
        flash[:error_subs] = "Hubo un erro al intentar suscribirte a nuestro boletín informativo."
      end
    end
    
    redirect_to '#SUBSCRIBER'
  end

  private
  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

  def set_subscriber
    @subscriber = Subscriber.find_by(:email => params[:subscriber][:email])
  end

end
