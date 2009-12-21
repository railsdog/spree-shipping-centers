require File.dirname(__FILE__) + '/../../../../../test/test_helper'
require File.dirname(__FILE__) + '/../factories/shipping_rule_factory'

class ShippingCenterTest < ActiveSupport::TestCase

  context "leadtime_for_product" do
    setup do
      # rule for shipping center with priority 1
      Factory(:shipping_rule, :priority => 1, :product_group => nil, :in_stock_leadtime => '2 days')

      # rules for shipping center with priority 2
      @shipping_center = Factory(:shipping_center, :priority => 2)
      Factory(:shipping_rule, :priority => 1, :product_group => nil, :shipping_center => @shipping_center, :in_stock_leadtime => '1 day')
      Factory(:shipping_rule, :priority => 2, :product_group => nil, :shipping_center => @shipping_center, :out_of_stock_leadtime => '1 week', :accepts_out_of_stock_products => false)
      Factory(:shipping_rule, :priority => 3, :product_group => nil, :shipping_center => @shipping_center, :out_of_stock_leadtime => '2 weeks', :accepts_out_of_stock_products => true)

      @product = Factory(:product)
    end

    context "on instance" do
      should "should return leadtime for first matching rule" do
        @product.stubs(:has_stock?).returns(true)
        assert_equal '1 day', @shipping_center.leadtime_for_product(@product)

        @product.stubs(:has_stock?).returns(false)
        assert_equal '2 weeks', @shipping_center.leadtime_for_product(@product)
      end
    end

    context "on class" do
      should "should return leadtime for first matching rule" do
        @product.stubs(:has_stock?).returns(true)
        assert_equal '2 days', ShippingCenter.leadtime_for_product(@product)

        @product.stubs(:has_stock?).returns(false)
        assert_equal '2 weeks', ShippingCenter.leadtime_for_product(@product)
      end
    end
    

  end
  
end