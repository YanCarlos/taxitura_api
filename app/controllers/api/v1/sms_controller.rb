module Api::V1
  class SmsController < BaseController

    def index
    end

    def create
      @msm = SitMobile.send(params[:telefono], params[:mensaje])
      json_response(@msm, :created)
    end

    private
    def driver_params
      params.permit(
        :telefono, 
        :mensaje,
      )
    end
  end
end
