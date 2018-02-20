require "csv"
require "pry"

# access CSV and other type use require relative
FILE_NAME = "../support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # gets the total plus tax of all of the products
    def total
      product_total = 0
      subtotal = 0
      @products.each_value do |prices|
        subtotal += prices
      end
      product_total = (subtotal * 0.075).round(2)+ subtotal
      return product_total

    end
    # Adds new product to @product array
    def add_product(product_name, product_price)

      if @products.include?(product_name)

        return false
      else
        @products[product_name]= product_price
        return true
      end
      return products

    end

    def self.all
      all_orders = []
      all_orders_split = []
      CSV.open(FILE_NAME, 'r').each do |file|
        all_orders << file
      end
      # sets the order id
      all_orders.each do |order|
        id = order[0].to_i
        # breaks the product string up
        order_split = order[1].split(';')
        # breaks the product string up again into key/value pairs
        order_hash = {}
        order_split.each do |product|
          items = product.split(':')
          # assigns product key/value pairs to a hash
          product_key = items[0]
          product_value = items[1].to_f
          order_hash[product_key] = product_value
        end
        order =  Order.new(id, order_hash)
        all_orders_split << order

      end
      return all_orders_split
    end

    def self.find(id)
      Grocery::Order.all.each do |order|
        if id == order.id
          return order.products
        end
      end


    end
  end
end


orders = Grocery::Order.all
puts orders.find(1)
