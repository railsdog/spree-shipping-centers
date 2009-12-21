group = ProductGroup.create(:name => "Ruby on Rails brand")
group.product_scopes.create(:name => "in_taxons", :arguments => ["Ruby on Rails"])

default_center = ShippingCenter.create(:name => 'Default', :priority => 1)

# Ruby on Rails branded items can ship in 2 days
default_center.shipping_rules.create(:priority => 1, :product_group => group, :in_stock_leadtime => "2 days")
# All other products will shipin 4
default_center.shipping_rules.create(:priority => 2, :in_stock_leadtime => "4 days")
