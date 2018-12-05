class DriversController < LockController
  before_action :set_driver, only: [:show, :update, :destroy, :edit]
  before_action :drivers, only: [:index]
  #before_action :get_foto, only: [:create, :update]

  def new
    @driver = User.new
  end

  def index
  end

  def edit

  end

  def show
  end

  def update
    if @driver.update(driver_params_edit)
      flash[:success] = 'El taxista fue actualizado correctamente!'
      redirect_to edit_driver_path(@driver)
    else
      flash[:error] = 'Error al actualizar el taxista!'
      render :edit
    end
  end

  def create
    @driver = User.new(driver_params)
    if @driver.save
      @driver.be_driver
      flash[:success] = 'El taxista fue registrado correctamente!'
      redirect_to edit_driver_path(@driver)
    else
      flash[:error] = 'Error al registrar el taxista!'
      render :new
    end
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
      :direccion,
      :docs,
      :photo
    )

  end

  def driver_params_edit
    params.require(:user).permit(
      :nombre, 
      :cedula,
      :email,
      :foto,
      :telefono, 
      :activo, 
      :direccion,
      :docs,
      :photo
    )

  end

  def set_driver
    @driver = User.find(params[:id])
  end

  def get_foto
    return if params[:foto].nil?
    params[:foto] = params[:foto]["content"]
  end

  def drivers
    @q = User.with_role(:driver).ransack(params[:q])
    @drivers = @q.result(distinct: true)
  end

end

