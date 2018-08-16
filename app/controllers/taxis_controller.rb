class TaxisController < ApplicationController
	before_action :taxis, only: [:index]

	def index
	end

	private
	def taxis
		@taxis = Taxi.all
	end
	
end
