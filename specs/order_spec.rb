require 'minitest/reporters'
#require 'minitest/skip_dsl'
require_relative '../lib/order'
#require 'CSV'

Minitest::Reporters.use!

# CSV.open("../support/orders.csv", "r") do |file|
#
# end

# describe "Order Wave 1" do
#   describe "#initialize" do
#     it "Takes an ID and collection of products" do
#       id = 1337
#       order = Grocery::Order.new(id, {})
#
#       order.must_respond_to :id
#       order.id.must_equal id
#       order.id.must_be_kind_of Integer
#
#       order.must_respond_to :products
#       order.products.length.must_equal 0
#     end
#   end
#
#   describe "#total" do
#     it "Returns the total from the collection of products" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       sum = products.values.inject(0, :+)
#       expected_total = sum + (sum * 0.075).round(2)
#
#       order.total.must_equal expected_total
#     end
#
#     it "Returns a total of zero if there are no products" do
#       order = Grocery::Order.new(1337, {})
#
#       order.total.must_equal 0
#     end
#   end
#
#   describe "#add_product" do
#     it "Increases the number of products" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       before_count = products.count
#       order = Grocery::Order.new(1337, products)
#
#       order.add_product("salad", 4.25)
#       expected_count = before_count + 1
#       order.products.count.must_equal expected_count
#     end
#
#     it "Is added to the collection of products" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       order.add_product("sandwich", 4.25)
#       order.products.include?("sandwich").must_equal true
#     end
#
#     it "Returns false if the product is already present" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#
#       order = Grocery::Order.new(1337, products)
#       before_total = order.total
#
#       result = order.add_product("banana", 4.25)
#       after_total = order.total
#
#       result.must_equal false
#       before_total.must_equal after_total
#     end
#
#     it "Returns true if the product is new" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       result = order.add_product("salad", 4.25)
#       result.must_equal true
#     end
#   end
# end
  describe 'remove_product' do

    it "returns true if the product is removed" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25}
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("salad")
      result.must_equal true
      products.length.must_equal 2
    end
  end
end


# # TODO: change 'xdescribe' to 'describe' to run these tests
# xdescribe "Order Wave 2" do
#   xdescribe "Order.all" do
#     it "Returns an array of all orders" do
#       # TODO:
#         result = Grocery::Order.all
#         result.must_be_instance_of Array
#          #result.each do |order|
#         #   order.must_be_an_instance_of Grocery::Order
#         # end
#         #order.must_equal 100
#       #end
#     end
#
#
#
#     it "Returns accurate information about the first order" do
#       # TODO:
#       # Arrange
#       products={"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93,
#          "Grape Seed Oil"=>74.9}
#       # Act
#       orders = Grocery::Order.all
#       first_order = orders[0]
#
#       # Assert
#       first_order.id.must_be_same_as 1
#       first_order.products.must_equal products
#
#     end
#
#     it "Returns accurate information about the last order" do
#       # TODO:
#       # Arrange
#       products = {"Allspice" => 64.74,
#         "Bran" => 14.72, "UnbleachedFlour" =>80.59}
#
#         #Act
#       orders = Grocery::Order.all
#       last_order = orders.last
#
#         # Assert
#       last_order.id.must_be_same_as 100
#       last_order.products.must_equal products
#
#       end
#
#
#   end
#
#
#   describe "Order.find" do
#     xit "Can find the first order from the CSV" do
#       # TODO: Your test code here!
#     # Arrange
#
#     first_order_id= 1
#     first_order_products = {"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93,
#        "Grape Seed Oil"=>74.9}
#
#     # Act
#       result_id = Grocery::Order.find(1).id
#       result_product =Grocery::Order.find(1).products
#
#     # Arrange
#      first_order_id.must_be_same_as result_id
#      first_order_products.must_equal result_product
#     end
#
#     xit "Can find the last order from the CSV" do
#       # TODO: Your test code here!
#       # Arrange
#       last_order_id = 100
#       last_order_product = {"Allspice" => 64.74,
#         "Bran" => 14.72, "UnbleachedFlour" =>80.59}
#       # Act
#       result_id = Grocery::Order.find(100).id
#       result_product = Grocery::Order.find(100).products
#
#       # Assert
#       last_order_id.must_be_same_as result_id
#       last_order_product.must_equal result_product
#
#     end
#
#     it "Raises an error for an order that doesn't exist" do
#       # TODO: Your test code here!
#     # Arrange
#     id = 206
#
#     # Act
#      Grocery::Order.find(id)
#
#     # Assert
#     proc { Grocery::Order.find(id) }.must_raise ArgumentError
#
#
#
#     end
#   end
# end
