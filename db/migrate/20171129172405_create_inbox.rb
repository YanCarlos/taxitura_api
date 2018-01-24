class CreateInbox < ActiveRecord::Migration[5.1]
  def change
    create_table :inboxes do |t|
      t.string :nombre
      t.string :email
      t.string :asunto
      t.string :mensaje
    end
  end
end
