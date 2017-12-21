class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.jsonb :info, default: {}
      t.timestamps 
    end
    add_index  :services, :info, using: :gin
  end
end
