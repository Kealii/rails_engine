class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :customer_id
      t.string :merchant_id
      t.string :status

      t.timestamps null: false
    end
  end
end
