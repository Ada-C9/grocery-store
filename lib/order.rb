require 'csv'
require 'awesome_print'
require 'pry'

FILENAME = "support/orders.csv"



module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0.0
      @products.each do |product, price|
        sum += price * 1.075
      end
      sum = sum.round(2)
      return sum
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        return true
        @products[:product_name] = product_price
        before_count = @products.count
        if @products.count == before_count + 1
          return true
        else
          return false
        end
      end
    end


    def self.all
      # data is an array of arrays
      data = CSV.read(FILENAME)
      # data and put into order format
      orders = []
      # create and empty products hash
      list = {}
      # take each line and grab the id number
      data.each do |line|
        id = line[0].to_i
        # ap line
        # take each string under the id number and split it at the ;
        products = line[1].split(";")#[1]
        products.each do |items|# take the string split at the : and assign them to key value pairs
          # ap products
          products = items.split(":")
          # orders << products
          # ap orders

          product_name = items[0]
          product_price = items[1].to_i

          # products[product_name] = product_price
          orders << Order.new(id, products)
        end
      end
      return orders
    end

    def self.find(id)
      self.all.each do |order|
        if order.id == id
          return order
        else
          return nil
        end #if statement
      end #self.all loop
    end # self.find(id) method
  end # Class Order
end # Module Grocery




# binding.pry
# Grocery::Order.all
#
# # display a the first product
# CSV.open(FILENAME,'r') do |file|
#   first_line = file.readline
#   puts "first line was #{first_line}"
#   data.each do |id, raw_products|
#     puts "Product: #{id}: #{raw_products}"
#   end
# end
