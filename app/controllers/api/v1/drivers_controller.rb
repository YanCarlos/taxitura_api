module Api::V1
  class DriversController < BaseController
    before_action :set_driver, only: [:show, :update, :destroy]

    def index
      @drivers = User.with_role :driver
      json_response(@drivers, @drivers.count)
    end

    def show
      json_response(@driver)
    end

    def update
      @driver.update(user_params)
      json_response(@driver)
    end

    def destroy
      @driver.destroy
      head :no_content
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
        :telefono, 
        :activo, 
        :direccion, 
        :password
      )
    end

    def set_driver
      @driver = User.find(params[:id])
    end

  end
end
