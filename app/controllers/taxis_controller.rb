class TaxisController < LockController
  before_action :taxis, only: [:index]
  before_action :set_taxi, only: [:edit, :update, :add_driver, :remove_driver]
  before_action :set_taxista, only: [:add_driver, :remove_driver]
  
  breadcrumb 'Taxis', :taxis_path
  breadcrumb 'Crear', :new_taxi_path, only: [:new]

  def index
  end

  def new
    @taxi = Taxi.new
  end

  def edit
    @drivers = User.with_role(:driver).where.not(id: @taxi.users.pluck(:id)).ransack(params[:q]).result 
  end

  def create
    @taxi = Taxi.new(taxi_params)
    if @taxi.save
      flash[:success] = 'El taxi fue registrado correctamente!'
      redirect_to edit_taxi_path(@taxi)
    else
      flash[:error] = 'Error al registrar el taxi!'
      render :new
    end
  end


  def update
    if @taxi.update_attributes(taxi_params)
      flash[:success] = 'El taxi fue modificado correctamente!'
      redirect_to edit_taxi_path(@taxi)
    else
      flash[:error] = 'Error al modificar el taxi!'
      render :new
    end
  end

  def logout_driver
    @taxi = Taxi.find(params[:taxi_id])
    if @taxi.logout(params[:user_id])
      redirect_back fallback_location: taxis_url, notice: 'El taxi ahora esta libre'
    else
      redirect_back fallback_location: taxis_url, notice: 'Problemas al cerrar sesión del taxi.'
    end
  end


  def add_driver
    if @taxista.assign_taxi(@taxi)
      redirect_back fallback_location: taxis_url, notice: "El taxista #{@taxista.nombre} fue agreado al taxi con placas #{@taxi.placa}."
    else
      redirect_back fallback_location: taxis_url, notice: 'Error al asignar taxista.'
    end
  end

  def remove_driver
    if @taxista.taxis.destroy(@taxi)
      redirect_back fallback_location: taxis_url, notice: "El taxista #{@taxista.nombre} fue removido del taxi con placas #{@taxi.placa}."
    else
      redirect_back fallback_location: taxis_url, notice: 'Error al remover taxista.'
    end
  end

  private

  def taxi_params
    params.require(:taxi).permit(
      :placa,
      :modelo,
      :marca,
      :baul,
      :ciudad,
      :proxima_revision,
      :telefono_propietario,
      :nombre_propietario,
      :activo
    )
  end

  def set_taxi
    id = params[:id] || params[:taxi_id]
    @taxi = Taxi.find(id)
  end

  def taxis
    @q = Taxi.ransack(params[:q])
    @taxis = @q.result(distinct: true)
  end

  def set_taxista
    @taxista = User.find(params[:user_id])
  end
end
