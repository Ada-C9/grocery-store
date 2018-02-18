require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here
require 'csv'

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do

      # Instatiate your OnlineOrder here
      # arrange, act
      online_order = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51,"Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26},14,"paid"
)
      # Check that an OnlineOrder is in fact a kind of Order
      # assert
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      # arrange
      customer = Grocery::Customer.find(14)

      # act
      online_order = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51,"Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26},14,"paid"
)

      # assert
      online_order.customer.id.must_equal customer.id
      online_order.customer.email.must_equal customer.email
      online_order.customer.street_address.must_equal customer.street_address
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      # arrange
      online_order_status = :paid

      # act
      online_order = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51,"Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26},14,"paid"
)

      # assert
      online_order.status.must_equal online_order_status
    end

  end # describe initialize

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      # arrange
      order = Grocery::Order.new(9,{"Iceberg lettuce"=>88.51,"Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26})
      order_total = order.total
      order_total_plus_shipping = order_total + 10.00

      # act
      online_order = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51,"Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26},14,"paid"
)

      # assert
      online_order.total.must_equal order_total_plus_shipping
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      # arrange
      order = Grocery::Order.new(9,{})
      order_total = order.total

      # act
      online_order = Grocery::OnlineOrder.new(9,{},14,"pending"
)

      # assert
      online_order.total.must_equal order_total
    end
  end # describe total

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      # arrange
      # act
      online_order_processing = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51},14,"processing")
      online_order_shipped = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51},14,"shipped")
      online_order_complete = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51},14,"complete")

      # assert
      proc { online_order_processing.add_product("Rice paper", 66.35) }.must_raise ArgumentError
      proc { online_order_shipped.add_product("Rice paper", 66.35) }.must_raise ArgumentError
      proc { online_order_complete.add_product("Rice paper", 66.35) }.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      # arrange
      # act
      online_order_pending = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51},14,"pending")
      online_order_paid = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51},14,"paid")

      # assert
      online_order_pending.add_product("Rice paper", 66.35).must_equal true
      online_order_paid.add_product("Rice paper", 66.35).must_equal true
    end
  end # describe add_product

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # arrange
      online_orders_row_count = 0
      CSV.open("support/online_orders.csv", "r").each do |order|
        online_orders_row_count += 1
      end

      # act
      online_orders_array = Grocery::OnlineOrder.all
      online_orders_array_length = online_orders_array.length

      # assert
      online_orders_array_length.must_equal online_orders_row_count
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      # arrange
      first_order_details = {"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21}

      # act
      first_order = Grocery::OnlineOrder.all[0]

      # assert
      first_order.id.must_equal 1
      first_order.products.must_equal first_order_details
      first_order.customer.id.must_equal 25
      first_order.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
      # arrange
      last_order_details = {"Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63}

      # act
      last_order = Grocery::OnlineOrder.all[99]

      # assert
      last_order.id.must_equal 100
      last_order.products.must_equal last_order_details
      last_order.customer.id.must_equal 20
      last_order.status.must_equal :pending
    end
  end # describe OnlineOrder.all

  xdescribe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end

  end # describe .find_by_customer

end # describe OnlineOrder
