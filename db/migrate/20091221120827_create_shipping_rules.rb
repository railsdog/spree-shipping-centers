class CreateShippingRules < ActiveRecord::Migration
  def self.up
    create_table :shipping_rules do |t|
      t.timestamps
      t.references :shipping_center, :product_group
      t.boolean :accepts_out_of_stock_products, :default => false
      t.string :in_stock_leadtime, :out_of_stock_leadtime
    end
  end

  def self.down
    drop_table :shipping_rules
  end
end
