require 'csv'
require 'awesome_print'



module Grocery
  class Order
    attr_reader :order_id, :products, :product_name, :product_price

    def initialize(order_id, products)
      @order_id = order_id
      @products = products
      @order_collection = []
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end

      total =  (subtotal + (subtotal * 0.075)).round(2)
    end

    def add_product(product_name, product_price)

      if @products.keys.include?(product_name)
        return result = false
        puts "#{@products[product_name]} was already in your cart"
      else
        @products[product_name] = product_price
        return result = true
        puts "#{@products[product_name]} added to your cart"
      end
    end

    def self.all

      @order_collection = []

      @order_list = []

      CSV.read(File.join(File.dirname(__FILE__),'../support/orders.csv')).each do |row|
        @order_list << {order_id: row[0], products: row[1].split(';')}
      end

      @order_list.each do |order|
        products_hash = {}
        order[:products].each do |item|
          product_price = item.split(':')
          product = product_price[0]
          price = product_price[1]
          products_hash[product] = price
        end
        order[:products] = products_hash

        @order_collection << Grocery::Order.new(order[:order_id], order[:products])

      end

      return @order_collection
    end


    def self.find(find_order_id)
      # will take one parameter (an order_id), returns one order from the CSV, return nil if order_id not found

      matched_order = nil

      order_list = Grocery::Order.all

      order_list.each do |order|
        if order.order_id == find_order_id
          matched_order = order
          break
        end
      end

      if (matched_order.nil?)
        raise RuntimeError "Invalid order ID"
      end

        return matched_order

    end

  end
end
