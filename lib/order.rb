require 'pry'
require 'csv'
require 'awesome_print'
# to get the CSV file:
FILE_NAME = "support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def total
      subtotal = 0
      @products.each do |product_name, product_price|
        # puts "A #{   product_name} costs $#{product_price}"
        subtotal += product_price
      end
      tax = (subtotal * 0.075).round(2)
      total = tax + subtotal
      total = total.round(2)
      # puts "the subtotal is $#{subtotal}"
      # puts "the tax is $#{tax}"
      # puts "the total is $#{total}"
      return total
    end

    def add_product(product_name, product_price)
      if @products.key?product_name
        return false # false because we don't have to add it cuz it's already there
      else
        @products[product_name] = product_price
        # product_name is the key
        # product_price is the value
        return true # true -- we *do* add it because it's not already in there
      end
    end

    def self.all
      orders = [] # this is here because I realized I needed it when I wrote "orders << order" at the end
      CSV.read(FILE_NAME).each do |row|
        # row looks like ["123", "Eggs:3.00;Milk:4.50"]
        # let's tackle id first
        id_string = row[0]
        id = id_string.to_i
        # let's tackle the products
        products_string = row[1]
        products_array = products_string.split(";")
        # let's loop inside products_array
        products_hash = {}
        products_array.each do |product|
          product_pair = product.split(":")
          product_name = product_pair[0]
          product_price = product_pair[1].to_f
          # now we put it into a hash
          products_hash[product_name] = product_price
        end
        order = Order.new(id, products_hash)
        orders << order
      end
      return orders
    end

      # def self.find(id)
      #   # how do i do this?!
      #
      #
      #
      # end




  end
end

binding.pry
