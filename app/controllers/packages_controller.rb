
class PackagesController < ApplicationController
	include Api::V1::Concerns::Response

	def index
      @packages = Package.order(nombre: :asc).all
      json_response(@packages, @packages.count)
    end
end
