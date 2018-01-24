module Api::V1
  class RechargesController < BaseController
    before_action :set_driver, only:[:index, :create, :update]
    before_action :set_package, only:[:create, :update]
    before_action :set_recharge, only:[:show]

    def index
      @recharges_for_driver = @driver.recharges.limit(15)
      json_response(@recharges_for_driver, @recharges_for_driver.count)
    end


    def show
      json_response(@recharge)
    end

    def create
      @recharge = Recharge.create!(recharge_params)
      json_response(@recharge, :created)
    end

    def update
      @recharge.update(recharge_params)
      json_response(@recharge, :updated)
    end
    

    private
    def recharge_params
      {
        user_id: @driver.id,
        cantidad_de_carreras: @package.cantidad_de_carreras,
        valor_de_carrera: @package.valor_de_carrera,
        utilidad_taxista: @package.utilidad_taxista,
        valor_de_paquete: @package.valor_de_paquete,
        ganancia_taxista: @package.ganancia_taxista,
        asistente_id: current_user.id,
        asistente_nombre: current_user.nombre,
        direccion: current_user.direccion,
        nombre_paquete: @package.nombre
      }
    end

    def set_package
      @package = Package.find(params[:package_id])
    end

    def set_driver
      @driver = User.find(params[:user_id])
    end

    def set_recharge
      @recharge = Recharge.find(params[:id])
    end





  end
end
