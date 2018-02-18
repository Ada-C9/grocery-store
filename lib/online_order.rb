require_relative './order'
require 'csv'
require 'awesome_print'


module Grocery
  class OnlineOrder < Order

    attr_reader :order_id, :products, :customer_id, :order_status

    @@online_orders = []

    def initialize(order_id, products, customer_id, order_status)
      @order_id = order_id
      @products = products
      @customer_id = customer_id
      @order_status = order_status
    end

    def self.all
      CSV.read('support/online_orders.csv', 'r').each do |line|
        line[0] = line[0].to_i
        order_id = line[0]
        groceries = []
        products = line[1].split(';')
        products.each do |items|
          groceries << items.split(':')
          products = groceries.to_h
          products.each {|key, val| products[key] = val.to_f}
        end
        customer_id = line[2].to_i
        order_status = line[3]

        @@online_orders << Grocery::OnlineOrder.new(order_id, products, customer_id, order_status)
      end
      return @@online_orders

    end

    def total
      online_total = super + 10
      return online_total.round(2)
    end

    def add_product(product_name, product_price)
      if @order_status == "pending" || @order_status == "paid"
        @products[product_name] = product_price
      else
        raise ArgumentError.new("Products can only be added to online orders with status of pending or paid.")
      end

    end

    def self.find(id)
      find_result = all.find { |order| order.order_id == id }
      if find_result == nil
        return "Error: Order ID does not exist"
      else
        return find_result
      end
    end

    def self.find_by_customer(customer_id)
      find_result = all.find_all { |order| order.customer_id == customer_id }
      if find_result.none?
        return ["Error: Order ID does not exist", find_result]
      else
        return find_result
      end
    end

  end
end

#   def total
#
#   def fulfillment_status
#
#   end
#
#   def find_by_customer
#
#
#   end
#
# end
#
# first_order = Grocery::OnlineOrder.all[0]
# #
# # ap first_order.total
# first_order = Grocery::OnlineOrder.all[1]
# ap first_order.add_product("salad", 4.25)
# ap first_order

# first_order = Grocery::OnlineOrder.all[0]
#
# add_to_order = first_order.add_product("salad", 4.25, "pending")
#
# puts add_to_order
# #
# ap Grocery::OnlineOrder.all
#
# Grocery::OnlineOrder.all
# ap Grocery::OnlineOrder.all[0]
# ap Grocery::OnlineOrder.find(1)

# ap Grocery::OnlineOrder.find_by_customer
# search = Grocery::OnlineOrder.find_by_customer(302)
# puts search
