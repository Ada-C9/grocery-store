require_relative './order'
require 'csv'
require 'awesome_print'


module Grocery
  class OnlineOrder < Order

    attr_reader :order_id, :products, :customer_id, :order_status

    @@online_orders = []

    def initialize(order_id, products, customer_id, order_status="pending") #if orderstatus not provided default value is pending)
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
      if products.count >= 1
        online_total = super + 10
        return online_total.round(2)
      else
        online_total = 0
        return online_total
      end
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
        raise ArgumentError.new("Products can only be added to online orders with status of pending or paid.")
      else
        return find_result
      end
    end

    def self.find_by_customer(customer_id)
      find_result = all.find_all { |order| order.customer_id == customer_id }
      return find_result
    end

  end
end
