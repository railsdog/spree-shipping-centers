require File.dirname(__FILE__) + '/../../../../../test/test_helper'
require File.dirname(__FILE__) + '/../factories/shipping_rule_factory'

class ShippingRuleTest < ActiveSupport::TestCase

  context "matches_product?" do
    setup do
      @in_stock_product = Factory(:product)
      @in_stock_product.stubs(:has_stock?).returns(true)
      @out_of_stock_product = Factory(:product)
      @out_of_stock_product.stubs(:has_stock?).returns(false)
      
      @rule = Factory(:shipping_rule)
    end

    should "be false if accepts_out_of_stock_products = false and product is out of stock" do
      assert !@rule.matches_product?(@out_of_stock_product)
    end
    should "be false if product is in stock but product isn't in product_group" do
      @rule.product_group.stubs(:include?).returns(false)
      assert !@rule.matches_product?(@in_stock_product)
    end
    should "be true if product is in stock and in product_group" do
      @rule.product_group.stubs(:include?).returns(true)
      assert @rule.matches_product?(@in_stock_product)
    end
    should "be true if product is out of stock and accepts_out_of_stock_products is true and in product_group" do
      @rule.product_group.stubs(:include?).returns(true)
      @rule.accepts_out_of_stock_products = true
      assert @rule.matches_product?(@out_of_stock_product)
    end
    should "be true if rule isn't assigned to a product_group and product is in stock" do
      @rule.product_group = nil
      assert @rule.matches_product?(@in_stock_product)
    end
  end
  
  context "leadtime_for_product" do

    setup do
      @product = Factory(:product)
      @product.stubs(:has_stock?).returns(true)
      @rule = Factory(:shipping_rule)
    end

    should "return nil unless product matches rule" do
      @rule.stubs(:matches_product?).returns(false)
      assert_nil @rule.leadtime_for_product(@product)
    end

    should "return in stock leadtime if product matches rule" do
      @rule.stubs(:matches_product?).returns(true)
      assert_equal @rule.in_stock_leadtime, @rule.leadtime_for_product(@product)
    end

    should "return out of stock leadtime if produt is out of stock" do
      @rule.stubs(:matches_product?).returns(true)
      @product.stubs(:has_stock?).returns(false)
      assert_equal @rule.out_of_stock_leadtime, @rule.leadtime_for_product(@product)
    end

  end
  
end