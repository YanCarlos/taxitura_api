class CreateSubscriber < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribers do |t|
      t.string :email
    end
  end
end
