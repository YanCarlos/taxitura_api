class AddDefaultToTaxi < ActiveRecord::Migration[5.1]
  def change
    change_column :taxis, :ocupado, :boolean, default: false
  end
end
