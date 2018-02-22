# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# require_relative '../lib/online_order'
# require 'csv'
# require 'pry'
#
#
# describe "OnlineOrder" do
#   describe "#initialize" do
#     it "Is a kind of Order" do
#       online_order = OnlineOrder.new(1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00})
#       online_order.must_be_kind_of Grocery::Order
#     end
#
#     it "Can access Customer object" do
#       online_order = OnlineOrder.new(1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00})
#       test = online_order.find_by_customer(1)
#       test.must_equal ([1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00}])
#     end
#
#     it "Can access the online order status" do
#       online_order = OnlineOrder.new(1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00})
#       test = online_order.status
#       test.must_equal (:paid)
#     end
#   end
#
#   describe "#total" do
#     it "Adds a shipping fee" do
#       online_order = OnlineOrder.new(1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00})
#       test = online_order.total
#       test.must_equal (10 + 4.99 + 9)
#     end
#
#     it "Doesn't add a shipping fee if there are no products" do
#       online_order = OnlineOrder.new(1, 1, "paid", {})
#       test = online_order.total
#       test.must_equal 0
#     end
#
#     describe "#add_product" do
#       it "Does not permit action for processing, shipped or completed statuses" do
#         online_order = OnlineOrder.new(1, 1, "processing", {"tempeh":4.99, "pokebowl":9.00})
#         test = online_order.add_product("nips":1.00)
#         test.must_equal raise ArgumentError.new "Argument Error: product status."
#         online_order = OnlineOrder.new(1, 1, "shipped", {"tempeh":4.99, "pokebowl":9.00})
#         test = online_order.add_product("nips":1.00)
#         test.must_equal raise ArgumentError.new "Argument Error: product status."
#         online_order = OnlineOrder.new(1, 1, "completed statuses", {"tempeh":4.99, "pokebowl":9.00})
#         test = online_order.add_product("nips":1.00)
#         test.must_equal raise ArgumentError.new "Argument Error: product status."
#       end
#
#       it "Permits action for pending and paid satuses" do
#         online_order = OnlineOrder.new(1, 1, "pending", {"tempeh":4.99, "pokebowl":9.00})
#         test = online_order.add_product("nips" => 1.00)
#         test.must_equal ({"tempeh":4.99, "pokebowl":9.00, "nips":1.0})
#         online_order = OnlineOrder.new(1, 1, "paid satuses", {"tempeh":4.99, "pokebowl":9.00})
#         test = online_order.add_product("nips":1.00)
#         test.must_equal ({"tempeh":4.99, "pokebowl":9.00, "nips":1.0})
#       end
#     end
#
#     describe "OnlineOrder.all" do
#       it "Returns an array of all online orders" do
#         result = OnlineOrder.all
#         result.must_equal (CSV.read("/support/online_orders.csv"))
#       end
#
#       it "Returns accurate information about the first online order" do
#         result = OnlineOrder.all
#         result_first = result[0]
#         test_result = CSV.read("support/online_orders.csv")
#         test_first = test_result[0]
#         result_first.must_equal test_first
#       end
#
#       it "Returns accurate information about the last online order" do
#         result = OnlineOrder.all
#         result_first = result[-1]
#         test_result = CSV.read("support/online_orders.csv")
#         test_first = test_result[-1]
#         result_first.must_equal test_first
#       end
#     end
#
#     describe "OnlineOrder.find" do
#       it "Will find an online order from the CSV" do
#         result = OnlineOrder.find(100)
#         result.must_equal ([100, 20, :pending, {"Amaranth":83.81, "Smoked Trout":70.6, "Cheddar":5.63}])
#       end
#
#       it "Raises an error for an online order that doesn't exist" do
#         result = OnlineOrder.find(1000)
#         result.must_equal ("Error, id number entry exeeds program parameters.")
#       end
#
#     end
#
#     describe "OnlineOrder.find_by_customer" do
#       it "Returns an array of online orders for a specific customer ID" do
#         result = OnlineOrder.find_by_customer(100)
#         result.must_equal ([100, 20, :pending, {"Amaranth":83.81, "Smoked Trout":70.6, "Cheddar":5.63}])
#       end
#
#       it "Raises an error if the customer does not exist" do
#         result = OnlineOrder.find_by_customer(1000)
#         result.must_equal false
#       end
#
#       it "Returns an empty array if the customer has no orders" do
#         result = OnlineOrder.find_by_customer(1000)
#         result.must_equal false
#       end
#     end
#   end
# end
