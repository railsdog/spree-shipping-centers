class ShippingCentersHooks < Spree::ThemeSupport::HookListener

  insert_after :product_price do
    %(
    <p><% if leadtime = @product.leadtime %>
      Ships in <%= @product.leadtime %>
    <% else %>
      Shipping time unknown
    <% end %></p>
    )
  end
 
end
