require "csv"
require "ap"



module Grocery
  class Order
    attr_accessor :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def total
      sum =   @products.values.sum
      return sum + (sum * 0.075).round(2)
    end

    def add_product (product_name, product_price)
      if @products.keys.include?(product_name) != true
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end
    #"Returns an array of all orders"
    def self.all
      data_array = CSV.read("support/orders.csv", "r")
      orders = []
      data_array.each do |order|
        products_hash = {}
        order[1].split(';').each do |product|
          array_product_price = product.split(":")
          products_hash[array_product_price[0]] = array_product_price[1]
        end
        orders <<   Order.new(order[0],products_hash)
      end
      return orders
    end

    def self.find(id_number)
      orderlist =  self.all
      the_order = nil
      orderlist.each do |order|
        if order.id == id_number
           the_order = order
        end

      end
      return the_order
    end
  end
end

#
# Update the Order class to be able to handle all of the fields from the CSV file used as input
csv_array_data = CSV.read("support/orders.csv", "r")










# To try it out, manually choose the data from the first line of the CSV file and ensure you can create a new instance of your Order using that data
# Add the following class methods to your existing Order class
# self.all - returns a collection of Order instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
# Determine if the data structure you used in Wave 1 will still work for these new requirements
# Note that to parse the product string from the CSV file you will need to use the split method
# self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
# Error Handling
# What should your program do if Order.find is called with an ID that doesn't exist?
# CSV Data File
