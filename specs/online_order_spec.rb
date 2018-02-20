require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
Minitest::Test.make_my_diffs_pretty!
require 'minitest/skip_dsl'

require_relative '../lib/customer'
require_relative '../lib/order'
require_relative '../lib/online_order'

describe "OnlineOrder" do

  # Creates a generic, normal instance of Order to run tests on
  before do
    @normal_products = { "sandwich" => 9.99, "gum" => 1.0 }
    @normal_order_id = 121
    @customer_id = 9999
    @normal_order = Grocery::OnlineOrder.new(@normal_order_id, @normal_products,
      @customer_id, :pending)
    @normal_total = ((9.99 + 1.0) + ((9.99 + 1.0) * 0.075)).round(2) + 10.0
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      @normal_order.must_be_kind_of Grocery::Order

    end

    it "Can access Customer object" do
      @normal_order.must_respond_to :customer
      @normal_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      @normal_order.fulfillment_status.must_be_kind_of Symbol
      @normal_order.fulfillment_status.must_equal :pending
    end

    it "Can provide its own the online order status" do
      status = :shipped
      test_order = Grocery::OnlineOrder.new(@normal_order_id,
        @normal_products, @customer_id, status)

      test_order.fulfillment_status.must_be_kind_of Symbol
      test_order.fulfillment_status.must_equal status
    end

    it "Sets invalid status to pending" do
      status = "ferrets"
      test_order = Grocery::OnlineOrder.new(9999, {"gum" => 1.0 }, 992, status)
      test_order.fulfillment_status.must_equal :pending
    end

    it "Does not need to be provided status" do
      test_order = Grocery::OnlineOrder.new(9999, {"gum" => 1.0 }, 992)
      test_order.fulfillment_status.must_equal :pending
    end

  end

  describe "#total" do
    it "Adds a shipping fee" do
      @normal_order.total.must_be_kind_of Float
      @normal_order.total.must_equal @normal_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      test_order = Grocery::OnlineOrder.new(@normal_order_id, {}, 999, :pending)
      test_order.total.must_be_kind_of Float
      test_order.total.must_equal 0.0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      test_order = Grocery::OnlineOrder.new(@normal_order_id, @normal_products,
        @customer_id, :shipped)

        assert_raises{test_order.add_product("apple", 1.0)}
        test_order.total.must_equal @normal_total

    end

    it "Permits action for pending and paid satuses" do
      test_order = Grocery::OnlineOrder.new(
        @normal_order_id, {"diet coke" => 1.99, "muffins" => 3.00}, @customer_id,
        :pending)

      expected_total =
        ((1.99 + 3.0 + 1.0) + ((1.99 + 3.0 + 1.0) * 0.075)).round(2) + 10.0

      test_order.add_product("apple", 1.0)
      test_order.total.must_equal expected_total

    end
  end

end

describe "Online Order: All, Find, and Find by Customer" do

  expected_first_products = {"Lobster"=>17.18, "Annatto seed"=>58.38,
     "Camomile"=>83.21}
  expected_first_order_id = 1
  expected_first_customer_id = 25
  expected_first_status = :complete

  expected_last_products = {"Amaranth"=>83.81, "Smoked Trout"=>70.6,
     "Cheddar"=>5.63}
  expected_last_order_id = 100
  expected_last_customer_id = 20
  expected_last_status = :pending

  all_online_orders = Grocery::OnlineOrder.all

  describe "OnlineOrder.all" do

    it "Returns an array of all online orders" do
      all_online_orders = Grocery::OnlineOrder.all
      all_online_orders.must_be_kind_of Array
      all_online_orders.all? { |order| order.class == Grocery::OnlineOrder }
    end

    it "Returns accurate information about the first online order" do

      first_order = Grocery::OnlineOrder.all.first

      first_order.id.must_be_kind_of Integer
      first_order.id.must_equal expected_first_order_id

      first_order.products.must_be_kind_of Hash
      first_order.products.must_equal expected_first_products

      first_order.customer.id.must_be_kind_of Integer
      first_order.customer.id.must_equal expected_first_customer_id


      first_order.fulfillment_status.must_be_kind_of Symbol
      first_order.fulfillment_status.must_equal expected_first_status
    end

    it "Returns accurate information about the last online order" do

      last_order = Grocery::OnlineOrder.all.last

      last_order.id.must_be_kind_of Integer
      last_order.id.must_equal expected_last_order_id

      last_order.products.must_be_kind_of Hash
      last_order.products.must_equal expected_last_products

      last_order.customer.id.must_be_kind_of Integer
      last_order.customer.id.must_equal expected_last_customer_id


      last_order.fulfillment_status.must_be_kind_of Symbol
      last_order.fulfillment_status.must_equal expected_last_status
    end

  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      order_id_to_find = 61
      order_products_to_find = {"Sardines" => 9.93, "Zucchini" => 94.26}
      customer_id_to_find = 10
      order_status_to_find = :complete

      last_order = Grocery::OnlineOrder.find(order_id_to_find)

      last_order.id.must_be_kind_of Integer
      last_order.id.must_equal order_id_to_find

      last_order.products.must_be_kind_of Hash
      last_order.products.must_equal order_products_to_find

      last_order.customer.id.must_be_kind_of Integer
      last_order.customer.id.must_equal customer_id_to_find


      last_order.fulfillment_status.must_be_kind_of Symbol
      last_order.fulfillment_status.must_equal order_status_to_find

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
      #  Grocery::Customer.new(444, "adalovelace.gmail.com",
      #     {street: "42 Baker Street", city: "Seattle", state: "WA", zip: "98101"})
      #
      # Grocery::OnlineOrder.new(333, {}, 444, :pending)
      #
      # actual_product_array = Grocery::OnlineOrder.find_by_customer(444)
      # expected_product_array = []
      # actual_product_array.must_be_kind_of Array
      # actual_product_array.must_equal expected_product_array
    end
  end

end
