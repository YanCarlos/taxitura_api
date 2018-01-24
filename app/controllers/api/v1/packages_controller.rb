module Api::V1
  class PackagesController < BaseController
    before_action :set_package, only:[:update, :show, :destroy]

    def index
      @packages = Package.order(nombre: :asc).all
      json_response(@packages, @packages.count)
    end

    def show
      json_response(@package)
    end

    def create
      @package = Package.create!(package_params)
      json_response(@package, :created)
    end

    def update
      @package.update(package_params)
      json_response(@package, :updated)
    end

    def destroy
      @package.destroy
      head :no_content
    end


    private
    def package_params
      params.permit(
        :nombre, 
        :cantidad_de_carreras, 
        :valor_de_carrera, 
        :utilidad_taxista, 
        :valor_de_paquete
      )
    end

    def set_package
      @package = Package.find(params[:id])
    end


  end
end
