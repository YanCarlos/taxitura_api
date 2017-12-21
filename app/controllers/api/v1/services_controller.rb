module Api::V1
class ServicesController < ApplicationController
	before_action :set_service, only:[:update, :show, :destroy]

	include Concerns::Response

	def index
		if params[:driver_id]
			#@services = Service.where("info -> 'user' ? :id", id: '2')
			@services = Service.all
		end
		#Service.create(info: {"user"=>["id"=>['6']]})
		
		
    json_response(@services, @services.count)
	end

	def show
	end

	def destroy
		@service.destroy
		json_response(@service, :deleted)
	end

	def create
		@service = Service.create!(services_params)
    json_response(@service, :created)
	end

	private
		def services_params
			params.permit(
				:info
			)
		end

		def set_service
			@service = Service.find(params[:id])
		end
end
end