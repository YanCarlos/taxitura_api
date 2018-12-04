class PackagesController < LockController
	before_action :packages, only: [:index]
    before_action :set_package, only: [:edit, :update, :destroy]
  
    breadcrumb 'Paquetes', :packages_path
    breadcrumb 'Crear', :new_package_path, only: [:new]

	def index
      
    end

    def new
	    @package = Package.new
	end

	def edit
	end

	def create
	    @package = Package.new(package_params)
	    if @package.save
	      	flash[:success] = 'El paquete fue registrado correctamente!'
	      	redirect_to edit_package_path(@package)
	    else
	      	flash[:error] = 'Error al registrar el paquete!'
	      	render :new
	    end
	end


	def update
	    if @package.update_attributes(package_params)
	      	flash[:success] = 'El paquete fue modificado correctamente!'
	      	redirect_to edit_package_path(@package)
	    else
	      	flash[:error] = 'Error al modificar el paquete!'
	      	render :new
	    end
	end

	def destroy
		if @package.destroy
			flash[:success] = 'El paquete fue eliminado correctamente!'
		else
			flash[:error] = 'Error al eliminar el paquete'
		end
		redirect_to packages_path
	end

    private 
    	def package_params
	      	params.require(:package).permit(
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

		def packages
			@q = Package.ransack(params[:q])
	    	@packages = @q.result(distinct: true)
		end
end
 