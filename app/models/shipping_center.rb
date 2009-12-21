class ShippingCenter < ActiveRecord::Base
  has_many :shipping_rules, :order => 'priority'
  default_scope :order => 'priority'
  
  def self.leadtime_for_product(product)
    all.map{|center| center.leadtime_for_product(product)}.compact.first
  end
  
  def leadtime_for_product(product)
    shipping_rules.map{|rule| rule.leadtime_for_product(product)}.compact.first
  end

end
