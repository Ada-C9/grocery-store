require 'csv'
require 'awesome_print'
require_relative 'order.rb'
require 'pry'

module Grocery
  # the OnlineOrder is a subclass of Order
  class OnlineOrder < Grocery::Order
    attr_reader :id, :products, :customer_id, :order_status

    # set variable for status as a symbol and set to pending per req.
    def initialize(id, products, customer_id, order_status = :pending)
      super(id, products)
      @customer_id = customer_id
      @order_status = order_status
    end

    # def total (ternary operator if else)
    #   total = super
    #   if total == 0
    #     return 0
    #   else
    #     total += 10
    #   end
    #   return total
    # end
    def total
      total = super
      total == 0 ? 0 : total += 10
    end

    def add_product (product_name, product_price)
      if @order_status == :pending || @order_status == :paid
        super(product_name, product_price)
      else
        raise ArgumentError.new "not available to add unless status is pending or paid"
      end
    end

    def self.all
      online_orders = []
      CSV.read("support/online_orders.csv").each do |row|
        id = row[0].to_i # make id an integer
        products_split = row[1].split(';')
        products_hash = {}
        products_split.each do |product|
          product_pair = product.split(':')
          products_hash[product_pair[0]] = product_pair[1].to_f
        end
        customer_id = row[2].to_i
        @order_status = row[3].to_sym
        new_online_order = OnlineOrder.new(id, products_hash, customer_id, @order_status)
        online_orders << new_online_order
      end
      return online_orders
    end

    def self.find(id)
      online_orders = OnlineOrder.all
      online_orders.each do |entry|
        if entry.id == id
          return entry.products
        end
      end
      return nil
    end

    def self.find_by_customer(customer_id)
      online_orders = OnlineOrder.all
      online_orders_found = []
      online_orders.each do |entry|
        if entry.customer_id == customer_id
          online_orders_found  << entry
        end
      end
      return online_orders_found
    end

  end
end
