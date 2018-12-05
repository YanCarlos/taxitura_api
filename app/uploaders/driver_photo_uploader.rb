class DriverPhotoUploader < Shrine
	plugin :remove_attachment
  plugin :pretty_location
  plugin :processing
  plugin :versions
  plugin :validation_helpers

  ALLOWED_TYPES = %w[image/jpg image/jpeg image/png]

  Attacher.validate do
    validate_mime_type_inclusion ALLOWED_TYPES
  end

  process(:store) do |io|
    { photo: io }
  end

  def generate_location(io, context)
    class_name  = context[:record].class.name.downcase
    role =  :driver
    id = 	context[:record].id
    file_name = io.original_filename

    [class_name, role, id, file_name].compact.join('/')
  end  
  
end
