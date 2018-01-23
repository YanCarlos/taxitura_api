class AddWelcomeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :welcome, :boolean
  end
end
