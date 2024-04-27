class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :admin_user_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
