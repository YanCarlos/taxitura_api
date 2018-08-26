class Taxi < ApplicationRecord
  has_and_belongs_to_many :users
  scope :modelo_filter, ->(modelo) { where('modelo like ?', "#{modelo}%") }

  private
  def self.ransackable_scopes(auth_object = nil)
    %i(modelo_filter)
  end
end
