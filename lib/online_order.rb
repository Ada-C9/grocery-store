require 'csv'
require 'awesome_print'
require_relative 'order.rb'
module Grocery
  class OnlineOrder < Order
    attr_reader :customer,:status
    alias order_total total
    alias order_add_product add_product
    def initialize(order_id, products, customer, status)
      super(order_id, products)
      @customer = Grocery::Customer.find(customer)
      @status = status.to_sym
      @status ||= :pending
    end

    def total
      if products.length > 0
         return self.order_total + 10
      else
        return self.order_total
      end
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
        all_online_orders << {order_id: row[0], products: row[1].split(';'), customer: row[2], status: row[3]}
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
        online_orders_instances << Grocery::OnlineOrder.new(online_order[:order_id], online_order[:products], online_order[:customer], online_order[:status])
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
        raise ArgumentError "Invalid order ID"
      end

      return matched_order_id

    end

    def self.find_by_customer(customer)
      matched_customers = []

      online_orders_list = Grocery::OnlineOrder.all

      online_orders_list.each do |online_order|
        if online_order.customer == customer
          matched_customers << online_order
        end
      end

      return matched_customers

    end

  end
end
