module Api::V1
	class ChartsController < BaseController
		def index
			unless filter
	      json_response({:access => "denied"}.to_json, {:status => false}.count)
	    end
		end

		private
			def filter
				return unless params[:chart_type] and params[:driver_id]
				if params[:chart_type] == "all_service_driver"
					@data = ServicesHelper.get_services_by_driver params[:driver_id].to_i
					json_response(@data.count, @data.count)
				elsif params[:chart_type] == "driver_qualification"
					@data = ChartsHelper.get_services_by_driver params[:driver_id].to_i
					json_response(@data, @data.count)
				elsif params[:chart_type] == "last_recharge"
					@data = ChartsHelper.get_services_last_recharge params[:driver_id].to_i
					json_response(@data, @data.count)
				elsif params[:chart_type] == "services_by_months"
					@data = ChartsHelper.get_services_by_months params[:driver_id].to_i
					json_response(@data, @data.count)
				elsif params[:chart_type] == "services_by_days"
					@data = ChartsHelper.get_services_by_days params[:driver_id].to_i
					json_response(@data, @data.count)
				elsif params[:chart_type] == "services_status"
					@data = ServicesHelper.get_services_by_status "order"
					json_response(@data.count, @data.count)
				elsif params[:chart_type] == "time_occupied"
					@data = ChartsHelper.get_time_occupied params[:driver_id].to_i
					json_response(@data, @data.count)
				elsif params[:chart_type] == "time_arrive"
					@data = ChartsHelper.get_time_arrive params[:driver_id].to_i
					json_response(@data, @data.count)
				end
			end
	end
end