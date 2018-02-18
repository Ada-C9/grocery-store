require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
Minitest::Test.make_my_diffs_pretty!
require 'minitest/skip_dsl'

require_relative '../lib/customer'
require_relative '../lib/order'
require_relative '../lib/online_order'

describe "OnlineOrder" do
    fake_customer_id = 42
    # fake_email = "adalovelace.gmail.com"
    # fake_address = {street: "42 Baker Street", city: "Seattle", state: "WA",
      # zip_code: "98101-1820"}

    # fake_customer = Grocery::Customer.new(fake_customer_id, fake_email, fake_address)

    test_order_id = 121
    test_order_products = {"banana" => 1.99, "cracker" => 3.00}

    fake_online = Grocery::OnlineOrder.new(test_order_id,
      test_order_products, 42, :pending)

    # real_customer_id = 29
    # real_customer_email = "sister@mertz.co"
    # real_customer_address = {street: "943 Rasheed Walks", city: "Port Kara",
    #   state: "AK",zip_code: "79531"}


  describe "#initialize" do
    it "Is a kind of Order" do
      fake_online.must_be_kind_of Grocery::Order

    end

    it "Can access Customer object" do
      fake_online.must_respond_to :customer
      fake_online.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      fake_online.fulfillment_status.must_be_kind_of Symbol
      fake_online.fulfillment_status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      fake_online = Grocery::OnlineOrder.new(test_order_id,
        test_order_products, fake_customer_id, :pending)
        expected_total = ((1.99 + 3.0) + ((1.99 + 3.0) * 0.075)).round(2) + 10.0

      fake_online.total.must_be_kind_of Float
      fake_online.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      fake_online = Grocery::OnlineOrder.new(test_order_id,
        {}, fake_customer_id, :pending)
        fake_online.total.must_be_kind_of Float
        fake_online.total.must_equal 0.0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      fake_online_fail = Grocery::OnlineOrder.new(test_order_id,
        {"banana" => 1.99, "cracker" => 3.00}, fake_customer_id, :shipped)

        assert_raises{fake_online_fail.add_product("apple", 1.0)}
        fake_online_fail.total.must_equal 15.36

    end

    it "Permits action for pending and paid satuses" do
      new_fake_online = Grocery::OnlineOrder.new(3333,
        {"diet coke" => 1.99, "muffins" => 3.00}, 83, :pending)
      expected_total = ((1.99 + 3.0 + 1.0) + ((1.99 + 3.0 + 1.0) * 0.075)).round(2) + 10.0

      new_fake_online.add_product("apple", 1.0)

      new_fake_online.total.must_equal expected_total

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      array_of_all_orders = Grocery::OnlineOrder.all
      array_of_all_orders.must_be_kind_of Array
      assert array_of_all_orders.all? { |order| order.class == Grocery::OnlineOrder}
    end

    it "Returns accurate information about the first online order" do

      expected_first_order_products = {"Lobster"=>17.18,
        "Annatto seed"=>58.38, "Camomile"=>83.21}

      first_order = Grocery::OnlineOrder.all[0]

      first_order.id.must_be_kind_of Integer
      first_order.id.must_equal 1

      first_order.products.must_be_kind_of Hash
      first_order.products.must_equal expected_first_order_products

      first_order.customer.id.must_be_kind_of Integer
      first_order.customer.id.must_equal 25


      first_order.fulfillment_status.must_be_kind_of Symbol
      first_order.fulfillment_status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do

      expected_last_order_products = {"Amaranth"=>83.81,
        "Smoked Trout"=>70.6, "Cheddar"=>5.63}

      last_order = Grocery::OnlineOrder.all.last

      last_order.id.must_be_kind_of Integer
      last_order.id.must_equal 100

      last_order.products.must_be_kind_of Hash
      last_order.products.must_equal expected_last_order_products

      last_order.customer.id.must_be_kind_of Integer
      last_order.customer.id.must_equal 20


      last_order.fulfillment_status.must_be_kind_of Symbol
      last_order.fulfillment_status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      expected_last_order_products = {"Amaranth"=>83.81,
        "Smoked Trout"=>70.6, "Cheddar"=>5.63}

      last_order = Grocery::OnlineOrder.find(100)

      last_order.id.must_be_kind_of Integer
      last_order.id.must_equal 100

      last_order.products.must_be_kind_of Hash
      last_order.products.must_equal expected_last_order_products

      last_order.customer.id.must_be_kind_of Integer
      last_order.customer.id.must_equal 20


      last_order.fulfillment_status.must_be_kind_of Symbol
      last_order.fulfillment_status.must_equal :pending

    end

    it "Raises an error for an online order that doesn't exist" do
      assert_raises{Grocery::OnlineOrder.find(9999999)}
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      expected_product_array =[{"Peaches"=>46.34}, {"Iceberg lettuce"=>88.51,
        "Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26},
        {"Soymilk"=>47.55, "Longan"=>14.86, "Fish Sauce"=>85.19,
        "Cashews"=>28.49}]

      actual_product_array = Grocery::OnlineOrder.find_by_customer(14)

      actual_product_array.must_be_kind_of Array
      actual_product_array.must_equal expected_product_array

    end

    it "Raises an error if the customer does not exist" do
        assert_raises{Grocery::OnlineOrder.find_by_customer(9999999)}
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
