require 'pry'
require 'csv'
require 'awesome_print'
# to use the CSV file:
FILE_NAME = "support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    # How to calculate the order total
    def total
      subtotal = 0
      @products.each do |product_name, product_price|
        subtotal += product_price
      end
      tax = (subtotal * 0.075).round(2)
      total = tax + subtotal
      total = total.round(2)
      return total
    end

    # How to add a product to an order
    def add_product(product_name, product_price)
      if @products.key?product_name
        # Return 'false' because we don't have to add the product since it's already in the products list
        return false
      else
        # 'product_name' is the key
        # 'product_price' is the value
        @products[product_name] = product_price
        # Return 'true' because we *do* add the product since it's not in the products list
        return true
      end
    end

    # The Order.all method
    def self.all
      # Set up an empty array that will be populated with many orders
      all_orders = []
      CSV.read(FILE_NAME).each do |row|
        # Let's tackle id first
        id_string = row[0]
        id = id_string.to_i
        # Let's tackle the products
        products_string = row[1]
        products_array = products_string.split(";")
        # Set up an empty hash that will be populated at the end of the loop
        products_hash = {}
        # Let's loop inside products_array
        products_array.each do |product|
          product_pair = product.split(":")
          product_name = product_pair[0]
          product_price = product_pair[1].to_f
          # now we put it into a hash
          products_hash[product_name] = product_price
        end
        new_order = Order.new(id, products_hash)
        all_orders << new_order
      end
      return all_orders
    end

    # How to find orders by the ID number
    def self.find(needed_id)
      all_orders = Grocery::Order.all
      all_orders.each do |order|
        return order if order.id == needed_id
      end
      return nil
    end
  end
end

binding.pry
