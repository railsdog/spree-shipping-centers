class PriorityForShippingRulesAndShippingCenters < ActiveRecord::Migration
  def self.up
    add_column "shipping_centers", "priority", :integer
    add_column "shipping_rules", "priority", :integer
  end

  def self.down
    remove_column "shipping_centers", "priority"
    remove_column "shipping_rules", "priority"
  end
end