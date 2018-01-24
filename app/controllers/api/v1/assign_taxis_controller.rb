module Api::V1
  class AssignTaxisController < BaseController
    before_action :set_taxi, only:[:destroy, :index, :create]
    before_action :set_taxista, only:[:destroy, :index, :create]
 

    def index
      if params[:taxi_id]
        @colletion = @taxi.users
      elsif params[:user_id]
        @colletion = @taxista.taxis
      end
      json_response(@colletion, @colletion.count)      
    end


    def create
      json_response(@taxista.assign_taxi(@taxi), :created)
    end


    def destroy
      deteled = @taxista.taxis.destroy @taxi
      json_response(deteled, :deleted)
    end


    private
    def set_taxi
      return unless params[:taxi_id]
      @taxi = Taxi.find(params[:taxi_id])
    end

    def set_taxista
      return unless params[:user_id]
      @taxista = User.find(params[:user_id])
    end
  end
end

