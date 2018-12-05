class AddPhotoToUser < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :users, :photo_data
      add_column :users, :photo_data, :text
    end
  end
end
