require "csv"
require "awesome_print"

module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.each do |k,value|
        sum += value
      end
      sum = (sum + (sum * 0.075)).round(2)
    end

    def add_product(product_name, product_price)

      return false if @products.keys.include?(product_name)

      @products[product_name] = product_price

      return true
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      all_orders = []
      CSV.read('support/orders.csv', 'r').each do |row|
        products = row[1].split(';') # splits products string
        # turns products array strings into hashes
        product_hash = {}
        products.each do |string|
          product = string.split(':')
          product_hash[product[0]] = product[1]
        end

        all_orders << self.new(row[0], product_hash)
      end
      return all_orders
    end

    def self.find(id)
      all_orders = self.all
      all_orders.each do |order|
        if order.id == id
          return order
        elsif id == "first"
          return all_orders[0]
        elsif id == "last"
          return all_orders[-1]
        end
      end
      # will use proc syntax for testing
      raise ArgumentError.new("Error: Order does not exist.")
    end

  end
end
