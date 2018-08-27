class ChangeProximaRevisionInTaxi < ActiveRecord::Migration[5.1]
  def change
    remove_column :taxis, :proxima_revision
    add_column :taxis, :proxima_revision, :date
  end
end
