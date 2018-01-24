class Service < ApplicationRecord
  before_save do
    self.info = JSON.parse self.info
  end
end
