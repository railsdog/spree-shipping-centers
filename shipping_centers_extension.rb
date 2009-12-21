# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ShippingCentersExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/shipping_centers"

  # Please use shipping_centers/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    ProductGroup.class_eval do
      
      # Is a producted in the group (does it match the group's criteria?)
      def include?(product)
        !! products.find_by_id(product.id)
      end
      
    end

  end
end
