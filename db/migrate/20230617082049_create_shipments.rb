class CreateShipments < ActiveRecord::Migration[6.1]
  def change
    create_table :shipments do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :status
      t.string :place

      t.timestamps
    end
  end
end
