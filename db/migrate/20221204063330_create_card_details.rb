class CreateCardDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :card_details do |t|
      t.string :email
      t.string :card_number
      t.string :expiry
      t.string :cvv
      t.string :card_token

      t.timestamps
    end
  end
end
