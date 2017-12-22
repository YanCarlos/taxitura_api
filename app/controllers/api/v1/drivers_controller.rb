module Api::V1
  class DriversController < BaseController
    before_action :set_driver, only: [:show, :update, :destroy]
    before_action :get_foto, only: [:create, :update]

    def index
      unless filter
        @drivers = User.order(nombre: :asc).with_role :driver
        json_response(@drivers, @drivers.count)
      end
    end

    def show
      json_response(@driver)
    end

    def update
      @driver.update(driver_params)
      json_response(@driver)
    end

    def create
      @driver = User.create!(driver_params)
      @driver.be_driver
      json_response(@driver, 0 , :created)
    end

    private

    def driver_params
      params.permit(
        :nombre, 
        :cedula,
        :email,
        :foto,
        :telefono, 
        :activo, 
        :direccion
      )

    end

    def set_driver
      @driver = User.find(params[:id])
    end

    def get_foto
      return if params[:foto].nil?
      params[:foto] = params[:foto]["content"]
    end

   def filter
      return unless params[:search]
        @drivers = DriversHelper.get_driver_by_search params[:search]
        json_response(@drivers, @drivers.count)
    end

  end
end
