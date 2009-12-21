Factory.sequence(:shipping_center_name_sequence) {|n| "Center #{n}"}

Factory.define :shipping_center do |s|
  s.name { Factory.next(:shipping_center_name_sequence) }
  s.priority 1
end

Factory.define :shipping_rule do |s|
  s.association(:product_group, :factory => :product_group)
  s.association(:shipping_center, :factory => :shipping_center)

  s.accepts_out_of_stock_products false
  s.in_stock_leadtime '1 day'
  s.out_of_stock_leadtime '1 week'  
end

