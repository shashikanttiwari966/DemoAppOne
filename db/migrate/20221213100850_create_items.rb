class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.string :currency
      t.string :item_id

      t.timestamps
    end
  end
end
