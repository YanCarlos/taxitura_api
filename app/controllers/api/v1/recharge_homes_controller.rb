module Api::V1
  class RechargeHomesController < ApplicationController
    before_action :set_home, only:[:update, :destroy, :show]

    include Concerns::Response
    include Concerns::ExceptionHandler

    def index
      @homes = RechargeHome.all
      json_response(@homes, @homes.count)
    end

    def show
      json_response(@home)
    end

    def create
      @home = RechargeHome.create(home_params)
      json_response(@home, 0, :created)
    end

    def update
      @home.update(home_params)
      json_response(@home, :updated)
    end

    def destroy
      @home.destroy
      json_response(@home, :deleted)
    end

    private
    def home_params
      params.permit(
        :latitud,
        :longitud,
        :nombre,
        :direccion
      )
    end

    def set_home
      @home = RechargeHome.find(params[:id])
    end


  end
end
