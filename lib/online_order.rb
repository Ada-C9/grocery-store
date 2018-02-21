require 'csv'
require 'awesome_print'
require_relative 'order.rb'
module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id,:status
    alias order_total total
    alias order_add_product add_product
    def initialize(order_id, products, customer_id, status)
      super(order_id, products)
      @customer_id = customer_id
      @status = status.to_sym
      @status ||= :pending
    end

    def total
      return self.order_total + 10
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        return order_add_product(product_name, product_price)
      else
        raise ArgumentError.new("Sorry cannot add products when status is not pending or paid")
      end
    end

    def self.all
      all_online_orders = []
      online_orders_instances =[]

      CSV.read(File.join(File.dirname(__FILE__),'../support/online_orders.csv')).each do |row|
        all_online_orders << {order_id: row[0], products: row[1].split(';'), customer_id: row[2], status: row[3]}
      end

      all_online_orders.each do |order|
        products_hash = {}
        order[:products].each do |item|
          product_price = item.split(':')
          product = product_price[0]
          price = product_price[1].to_f
          products_hash[product] = price
        end
        order[:products] = products_hash
      end

      all_online_orders.each do |online_order|
        online_orders_instances << Grocery::OnlineOrder.new(online_order[:order_id], online_order[:products], online_order[:customer_id], online_order[:status])
      end

      return online_orders_instances
    end

    def self.find(order_id)
      matched_order_id = nil

      online_orders_list = Grocery::OnlineOrder.all

      online_orders_list.each do |online_order|
        if online_order.order_id == order_id
          matched_order_id = online_order
          break
        end
      end

      if (matched_order_id.nil?)
        raise RuntimeError "Invalid order ID"
      end

      return matched_order_id

    end

    def self.find_by_customer(customer_id)
      matched_customer_ids = []

      online_orders_list = Grocery::OnlineOrder.all

      online_orders_list.each do |online_order|
        if online_order.customer_id == customer_id
          matched_customer_ids << online_order
        end
      end

      if (matched_customer_ids.nil?)
        raise RuntimeError "Invalid customer ID"
      end

      return matched_customer_ids

    end

  end
end

# test = Grocery::OnlineOrder.new(1, [{}], 1, '')
# ap Grocery::OnlineOrder.all
ap test = Grocery::OnlineOrder.find("25")
ap test
ap test.order_total
ap test.total
ap test.add_product("coffee", 5)
# ap Grocery::OnlineOrder.find_by_customer("25")
