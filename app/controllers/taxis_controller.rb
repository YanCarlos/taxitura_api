class TaxisController < ApplicationController
  before_action :taxis, only: [:index]
  before_action :set_taxi, only: [:edit, :update]
  
  breadcrumb 'Taxis', :taxis_path
  breadcrumb 'Crear', :new_taxi_path, only: [:new]

  def index
  end

  def new
    @taxi = Taxi.new
  end

  def edit
  end

  def create
    taxi = Taxi.new(taxi_params)
    if taxi.save
      flash[:success] = 'El taxi fue registrado correctamente!'
      redirect_to edit_taxi_path(taxi)
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
    @taxi = Taxi.find(params[:id])
  end

  def taxis
    @q = Taxi.ransack(params[:q])
    @taxis = @q.result(distinct: true)
  end
end
