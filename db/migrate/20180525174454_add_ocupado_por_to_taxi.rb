class AddOcupadoPorToTaxi < ActiveRecord::Migration[5.1]
  def change
    add_column :taxis, :ocupado_por, :integer
  end
end
