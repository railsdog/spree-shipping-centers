class ShippingRule < ActiveRecord::Base
  belongs_to :product_group
  belongs_to :shipping_center
  
  def matches_product?(product)
    return false unless product.has_stock? || accepts_out_of_stock_products?
    product_group.nil? || product_group.include?(product)
  end
  
  def leadtime_for_product(product)
    return nil unless matches_product?(product)
    product.has_stock? ? in_stock_leadtime : out_of_stock_leadtime
  end
  
end
