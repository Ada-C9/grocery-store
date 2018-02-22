require 'awesome_print'
require 'csv'
require 'pry'
module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end

      tax = subtotal * 0.075

      return (subtotal + tax).round(2)
    end

    def add_product(product_name, product_price)
      if @products[product_name].nil?
        @products[product_name] = product_price
        return true
      end

      return false
    end

    def self.find(find_id)
      found_order = false
      @@organized_orders.each do |order|
        if @id == find_id
          found_order = order.products
        end
      end
      return found_order
    end

    def self.all
      organized_orders = []

      array_of_orders_data = CSV.read("support/orders.csv")

      array_of_orders_data.each do |order|
        products = Hash.new
        @id = order[0].to_i
        product_prices = order[1].split(";")
        product_prices.each do |product_price|
          product_price = product_price.split(":")
          products.store(product_price[0], product_price[1].to_f)
        end
        
        organized_orders << Order.new(order[0].to_i, products)
      end
      return organized_orders
    end
  end
end
