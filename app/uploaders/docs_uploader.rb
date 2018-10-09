class DocsUploader < Shrine
  plugin :remove_attachment
  plugin :pretty_location
  plugin :processing
  plugin :versions
  plugin :validation_helpers

  ALLOWED_TYPES = %w[application/zip application/rar]

  Attacher.validate do
    validate_mime_type_inclusion ALLOWED_TYPES
  end

  process(:store) do |io|
    { docs: io }
  end

  def generate_location(io, context)
    class_name  = context[:record].class.name.downcase
    role =  :driver
    name = 	context[:record].friendly_name
    file_name = io.original_filename

    [class_name, role, name, file_name].compact.join('/')
  end  
end
