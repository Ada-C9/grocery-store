require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/customer'
require 'awesome_print'
require 'csv'

Minitest::Reporters.use!

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  xdescribe "#initialize" do
    before do
      # 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
      # 25,summer@casper.io,66255 D'Amore Parkway,New Garettport,MO,57138
      customer = Grocery::Customer.new(25, "summer@casper.io", {})
      @online_order = OnlineOrder.new(1, {}, customer, :complete)
    end

    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      @online_order.must_respond_to :customer
      @online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      @online_order.must_respond_to :status
      @online_order.status.must_equal :complete
    end
  end

  xdescribe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      # 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
      products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      online_order = OnlineOrder.new(1, products, nil, nil)

      expected_total = (17.18 + 58.38 + 83.21) * 1.075 + 10

      online_order.total.must_equal expected_total.round(2)
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      online_order = OnlineOrder.new(1, {}, nil, nil)

      online_order.total.must_equal 0
    end
  end

  xdescribe "#add_product" do
    # TODO: FIX BUG HERE!
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      # 3,Vegetable spaghetti:37.83;Dates:90.88;WhiteFlour:3.24;Caraway Seed:54.29,5,processing
      # 5,Sour Dough Bread:35.11,21,shipped
      # 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order_processing = OnlineOrder.new(3, products, nil, :processing)
      online_order_shipped = OnlineOrder.new(5, products, nil, :shipped)
      online_order_complete = OnlineOrder.new(1, products, nil, :complete)

      proc {online_order_processing.add_product("sandwich", 4.25)}.must_raise ArgumentError
      proc {online_order_shipped.add_product("sandwich", 4.25)}.must_raise ArgumentError
      proc {online_order_complete.add_product("sandwich", 4.25)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      # 6,Peaches:46.34,14,pending
      # 2,Sun dried tomatoes:90.16;Mastic:52.69;Nori:63.09;Cabbage:5.35,10,paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order_pending = OnlineOrder.new(6, products, nil, :pending)
      online_order_paid = OnlineOrder.new(2, products, nil, :paid)

      online_order_pending.add_product("sandwich", 4.25)
      online_order_paid.add_product("sandwich", 4.25)

      online_order_pending.products.include?("sandwich").must_equal true
      online_order_paid.products.include?("sandwich").must_equal true
    end
  end

  xdescribe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      online_orders = OnlineOrder.all

      online_orders.must_be_instance_of Array
      online_orders.each do |online_order|
        online_order.must_be_instance_of OnlineOrder
      end
      online_orders.length.must_equal 100
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      online_orders = OnlineOrder.all
      first_online_order = online_orders.first


      # 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
      first_online_order.id.must_equal 1
      first_online_order.products["Lobster"].must_equal 17.18
      first_online_order.products["Annatto seed"].must_equal 58.38
      first_online_order.products["Camomile"].must_equal 83.21
      first_online_order.customer.id.must_equal 25
      first_online_order.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
      online_orders = OnlineOrder.all
      last_online_order = online_orders.last

      # 100,Amaranth:83.81;Smoked Trout:70.6;Cheddar:5.63,20,pending
      last_online_order.id.must_equal 100
      last_online_order.products["Amaranth"].must_equal 83.81
      last_online_order.products["Smoked Trout"].must_equal 70.6
      last_online_order.products["Cheddar"].must_equal 5.63
      last_online_order.customer.id.must_equal 20
      last_online_order.status.must_equal :pending
    end
  end

  xdescribe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
      online_order_found_first = OnlineOrder.find(1)
      online_order_found_last = OnlineOrder.find(100)

      online_order_found_first.id.must_equal 1
      online_order_found_first.products["Lobster"].must_equal 17.18
      online_order_found_first.products["Annatto seed"].must_equal 58.38
      online_order_found_first.products["Camomile"].must_equal 83.21
      online_order_found_first.customer.id.must_equal 25
      online_order_found_first.status.must_equal :complete

      online_order_found_last.id.must_equal 100
      online_order_found_last.products["Amaranth"].must_equal 83.81
      online_order_found_last.products["Smoked Trout"].must_equal 70.6
      online_order_found_last.products["Cheddar"].must_equal 5.63
      online_order_found_last.customer.id.must_equal 20
      online_order_found_last.status.must_equal :pending
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
      online_order_found = OnlineOrder.find(101)

      online_order_found.must_be_nil
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      # 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
      # 20,Cornmeal:32.21;Soba:23.91;Potatoes:81.6,25,complete
      # 28,Oatmeal:55.88;Celery:14.88;Sake:16.81;Smoked Trout:40.67,25,shipped
      # 51,Currants:47.33;Arrowroot:45.83,25,shipped
      # 72,Baking Powder:16.76;Calamari:37.5;Chinese Five Spice:5.77,25,processing
      # 95,Rice Noodles:77.36;Scallops:64.53,25,shipped
      online_orders_found = OnlineOrder.find_by_customer(25)

      online_orders_found.length.must_equal 6
      online_orders_found.each do |online_order|
        online_order.customer.id.must_equal 25
      end
    end

    it "Raises an empty array if the customer does not exist" do
      # TODO: Your test code here!
      online_orders_found = OnlineOrder.find_by_customer(36)

      online_orders_found.must_be_instance_of Array
      online_orders_found.length.must_equal 0
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
      online_orders_found = OnlineOrder.find_by_customer(16)

      online_orders_found.must_be_instance_of Array
      online_orders_found.length.must_equal 0
    end
  end
end
