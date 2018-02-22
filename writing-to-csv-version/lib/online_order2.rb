# require 'csv'
# require 'faker'
#
# require_relative '../lib/order2'
# require_relative '../lib/customer2'
# # require_relative './order2'
# # require_relative './customer2'
#
#
#
# module GroceryTwo
#
#   class OnlineOrderTwo < OrderTwo
#     attr_reader :customer, :fulfillment_status#, :id, :products
#
#     @@all_online_orders = []
#
#     def initialize(initial_id, initial_products, initial_customer_id,
#       initial_fulfillment)
#       super(initial_id, initial_products)
#       @customer = get_customer(initial_customer_id)
#       @fulfillment_status = :pending
#       set_initial_fulfillment_status(initial_fulfillment)
#     end
#
#     def total
#       total_order_cost = super
#       return total_order_cost > 0.0 ? total_order_cost + 10.0 : total_order_cost
#     end
#
#     def add_product(product_name, product_cost)
#       if !(@fulfillment_status == :pending || @fulfillment_status == :paid)
#         raise ArgumentError.new("Can only add product when online order is pending or paid.")
#       end
#       super(product_name, product_cost)
#     end
#
#
#     # self.all - returns a collection of OnlineOrder instances, representing
#     # all of the OnlineOrders described in the CSV. See below for the CSV file
#     # specifications
#     #
#     # Question Ask yourself, what is different about this all method versus the
#     # Order.all method? What is the same?
#     #
#     # self.find(id) - returns an instance of OnlineOrder where the value of the
#     # id field in the CSV matches the passed parameter. -Question Ask yourself,
#     # \what is different about this find method versus the Order.find method?
#
#     # self.find_by_customer(customer_id) - returns a list of OnlineOrder
#     # instances where the value of the customer's ID matches the passed parameter.
#
#
#     #
#     def self.all
#       if @@all_online_orders.empty? # TODO: uncomment these when done!!
#         CSV.read("../support/online_orders2.csv").each do |order_line|
#           order_id = order_line[0].to_i
#           product_hash = {}
#           order_line[1].scan(/[^\;]+/).each do |order|
#             name, price = order.split(":")
#             product_hash["#{name}"] = price.to_f
#           end
#           customer_id = order_line[2].to_i
#           order_status = order_line[3].to_sym
#           @@all_online_orders << GroceryTwo::OnlineOrderTwo.new(order_id, product_hash, customer_id,
#             order_status)
#         end
#       end
#       return @@all_online_orders
#     end
#
#     #
#     def self.find(requested_id)
#       order_with_requested_id = all.find { |order| order.id == requested_id }
#       if order_with_requested_id.nil?
#         raise ArgumentError.new("No online order with id #{requested_id.inspect}.")
#       end
#       return order_with_requested_id
#     end
#
#     #
#     def self.find_by_customer(requested_customer_id)
#       return if GroceryTwo::OnlineOrderTwo.find(requested_customer_id).nil?
#       orders_of_customer = []
#       all.each do |order|
#         orders_of_customer << order.products if order.customer.id == requested_customer_id
#       end
#       return orders_of_customer
#     end
#
#     private
#
#     #
#     def get_customer(customer_id)
#       order_customer = GroceryTwo::CustomerTwo.find(customer_id)
#       if order_customer.nil? # creates a new fake customer if can't find id
#         order_customer = GroceryTwo::CustomerTwo.new(customer_id, Faker::Internet.email,
#         {street: Faker::Address.street_address, city:Faker::Address.city,
#           state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code})
#       end
#       return order_customer
#     end
#
#     def set_initial_fulfillment_status(possible_status)
#       @fulfillment_status =
#       is_valid_fulfillment_status?(possible_status) ? possible_status : :pending
#     end
#
#
#     def is_valid_fulfillment_status?(possible_status)
#       return possible_status.class == Symbol && %i[pending paid processing
#         shipped complete].any?(possible_status)
#     end
#
#   end
#
# end
#
# # print Grocery::OnlineOrder.find_by_customer(14)
