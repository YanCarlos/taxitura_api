module Api::V1
  class ServicesController < ApplicationController
    before_action :set_service, only:[:update, :show, :destroy]
    
    include Concerns::Response

    def index
      unless filter
        @services = Service.all
        json_response(@services, @services.count)
      end
    end

    def show
      json_response(@service)
    end

    def destroy
      @service.destroy
      json_response(@service, :deleted)
    end

    def create
      @service = Service.create!(services_params)
      json_response(@service, :created)
    end

    def update
      @service.update!(services_params)
      json_response(@service, :updated)
    end

    private
      def services_params
        params.permit(
          :info
        )
      end

      def set_service
        @service = ServicesHelper.get_service_by_id params[:id].to_i
      end

      def filter
        return unless (params[:filter_type] and params[:filter_params]) || (params[:filter_type] and params[:initial_date] and params[:end_date] and params[:filter_params])
        if params[:filter_type] == "driver"
          @services = ServicesHelper.get_services_by_driver params[:filter_params].to_i
        elsif params[:filter_type] == "user"
          @services = ServicesHelper.get_services_by_user params[:filter_params]
        elsif params[:filter_type] == "status"
          @services = ServicesHelper.get_services_by_status params[:filter_params]
        elsif params[:filter_type] == "last_user"
          @services = ServicesHelper.get_last_service_user params[:filter_params].to_i
        elsif params[:filter_type] == "last_driver"
          @services = ServicesHelper.get_last_service_cabman params[:filter_params].to_i
        elsif params[:filter_type] == "day"
          @services = ServicesHelper.get_service_by_date params[:initial_date], params[:end_date], params[:filter_params], params[:status]
        elsif params[:filter_type] == "multiple_services"
          @services = ServicesHelper.get_service_by_ids params[:filter_params]
        end
        json_response(@services, @services.count)
      end
  end
end
