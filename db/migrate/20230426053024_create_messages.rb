class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :admin_user_id
      t.integer :receiver_id
      t.text :body

      t.timestamps
    end
  end
end
