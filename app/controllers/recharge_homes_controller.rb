class RechargeHomesController < LockController
  	before_action :recharge_homes, only: [:index]
    before_action :set_home, only: [:edit, :update, :destroy]
  
    breadcrumb 'Puntos de recarga', :recharge_homes_path
    breadcrumb 'Crear', :new_recharge_home_path, only: [:new]

	def index
      
    end

    def new
	    @home = RechargeHome.new
	end

	def edit
	end

	def create
	    @home = RechargeHome.new(home_params)
	    if @home.save
	      	flash[:success] = 'El punto de recarga fue registrado correctamente!'
	      	redirect_to edit_recharge_home_path(@home)
	    else
	      	flash[:error] = 'Error al registrar el punto de recarga!'
	      	render :new
	    end
	end


	def update
	    if @home.update_attributes(home_params)
	      	flash[:success] = 'El punto de recarga fue modificado correctamente!'
	      	redirect_to edit_recharge_home_path(@home)
	    else
	      	flash[:error] = 'Error al modificar el punto de recarga!'
	      	render :new
	    end
	end

	def destroy
		if @home.destroy
			flash[:success] = 'El punto de recarga fue eliminado correctamente!'
		else
			flash[:error] = 'Error al eliminar el punto de recarga'
		end
		redirect_to recharge_homes_path
	end

    private 
    	def home_params
	      	params.require(:recharge_home).permit(
	        	:latitud,
        		:longitud,
        		:nombre,
        		:direccion
	      	)
	    end
    	def set_home
		   @home = RechargeHome.find(params[:id])
		end

		def recharge_homes
			@q = RechargeHome.ransack(params[:q])
	    	@homes = @q.result(distinct: true)
		end
end
