class CreateShippingCenters < ActiveRecord::Migration
  def self.up
    create_table :shipping_centers do |t|
      t.timestamps      
      t.string :name      
    end
  end

  def self.down
    drop_table :shipping_centers
  end
end
