require 'csv'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

ONLINE_FILE = 'support/online_orders.csv'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer

    def initialize(id, products, customer_id, status=:pending)
      @id = id
      @products = products
      @customer = Customer.find(customer_id)
      @status = status
    end

    def total
      super
      if @products.empty?
        return super
      else
        return super + 10
      end
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      elsif [:processing, :shipped, :complete].include?(@status)
        raise ArgumentError.new("The order status is #{@status}. New products can no longer be added to this order.")
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.all(csv_file=ONLINE_FILE)
      csv_array = CSV.read(csv_file, 'r')
      all_online_orders = []
      csv_array.each do |online_order|
        id = online_order[0].to_i
        products = Hash[online_order[1].split(/:|;/).each_slice(2).collect { |k, v| [k,v.to_f] }]
        customer_id = online_order[2].to_i
        status = online_order[3].to_sym
        new_online_order = OnlineOrder.new(id, products, customer_id, status)
        all_online_orders << new_online_order
      end
      return all_online_orders
    end

    def self.find(id, csv_file=ONLINE_FILE)
      OnlineOrder.all(csv_file).each do |object|
        if object.id == id
          return object
        end
      end
      raise ArgumentError.new("Order #{id} could not be found in the online order database.")
    end

    def self.find_by_customer(num, csv_file=ONLINE_FILE)
      Customer.find(num)
      online_orders =[]
      OnlineOrder.all(csv_file).each do |object|
        if object.customer.id == num
          online_orders << object
        end
      end
      return online_orders
    end
  end
end
