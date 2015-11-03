class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.string :item_id
      t.string :invoice_id
      t.string :quantity
      t.string :unit_price

      t.timestamps null: false
    end
  end
end
