class CreateJoinTableUserTaxi < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :taxis do |t|
      # t.index [:user_id, :taxi_id]
      # t.index [:taxi_id, :user_id]
      
      t.timestamps
    end
  end
end
