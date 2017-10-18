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
      @driver.update(driver_params)
      json_response(@driver)
    end

    def destroy
      @driver.destroy
      head :no_content
    end

    def create
      @driver = User.create!(driver_params)
      @driver.be_driver
      @driver.foto = foto_d
      json_response(@driver, 0 , :created)
    end

    private

    def driver_params
      params.permit(
        :nombre, 
        :cedula,
        :foto, 
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

    def foto_d
      binding.pry
      if params[:picture][:picture_path]["file"]
         picture_path_params = params[:picture][:picture_path]
         #create a new tempfile named fileupload
         tempfile = Tempfile.new("fileupload")
         tempfile.binmode
         #get the file and decode it with base64 then write it to the tempfile
         tempfile.write(Base64.decode64(picture_path_params["file"]))

         #create a new uploaded file
         uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => picture_path_params["filename"], :original_filename => picture_path_params["original_filename"]) 

         #replace picture_path with the new uploaded file
         params[:picture][:picture_path] =  uploaded_file
      end
    end


  end
end
