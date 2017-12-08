module Api::V1
class TaxisController < BaseController

	before_action :set_taxi, only:[:update, :destroy, :show]

	def index
		@taxis = Taxi.all
		json_response(@taxis, @taxis.count)
	end

	def create
		@taxi = Taxi.create(taxi_params)
		json_response(@taxi, 0, :created)
	end 

	def show 
		json_response(@taxi)
	end 

	def update
		@taxi.update(taxi_params)
		json_response(@taxi, :updated)
	end 

	def destroy
		@taxi.destroy
		json_response(@taxi, :deleted)
	end

	private 

		def taxi_params
			params.permit(
				:placa,
				:ciudad,
				:marca,
				:modelo,
				:baul,
				:nombre_propietario,
				:telefono_propietario,
				:proxima_revision,
				:activo
			)
		end 

		def set_taxi
			@taxi = Taxi.find(params[:id])
		end

	end
end 