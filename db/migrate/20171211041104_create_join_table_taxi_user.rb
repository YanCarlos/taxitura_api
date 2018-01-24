class CreateJoinTableTaxiUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :taxis, :users do |t|
      t.index [:taxi_id, :user_id]
    end
  end
end
