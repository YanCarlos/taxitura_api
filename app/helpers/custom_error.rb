class CustomError <  StandardError
  def self.send message
    raise CustomError, message
  end
end
