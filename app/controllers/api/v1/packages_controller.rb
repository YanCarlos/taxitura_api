module Api::V1
  class PackagesController < BaseController
    before_action :set_package, only:[:update, :show]

    def index
      @packages = Package.all
      json_response(@packages, @packages.count)
    end

    def show
      json_response(@package)
    end

    def create
      @package = Package.create!(package_params_create)
      json_response(@packages, :created)
    end

     def update
      @package.update(package_params_update)
      json_response(@packages, :updated)
    end


    private
    def package_params_create
      params.permit(
        :nombre, 
        :cantidad_de_carreras, 
        :valor_de_carrera, 
        :utilidad_taxista, 
        :valor_de_paquete
      )
    end

    def package_params_update
      params.permit(
        :nombre
      )
    end

    def set_package
      @package = Package.find(params[:id])
    end


  end
end
